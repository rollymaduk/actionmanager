resetSelector=(field)->
  table=Session.get('selectedWidget').data.table
  modifier={fields:{}}
  modifier.fields[field]=1 if _.isString(field)
  selector={table:table}
  selector[field]={$regex:'.*',$options:'i'} if _.isString(field)
  query={selector:selector,modifier:modifier}
  Template.manageFilters.query.set(query)
  Template.manageFilters.selectedField.set field if _.isString(field)
  console.log query

Template.manageFilters.created=->
  table=Session.get('selectedWidget').data.table
  Template.manageFilters.query=new ReactiveVar({table:table})
  Template.manageFilters.selectedField=new ReactiveVar(null)
  @autorun (c)->
    bigSubs.subscribe('tabledata',Template.manageFilters.query.get().selector,100)
    null
  resetSelector()

Template.manageFilters.events
  "change select[data-schema-key='field']":(evt,temp)->
    resetSelector(evt.target.value)


Template.manageFilters.helpers
  fields:->
    table=Session.get('selectedWidget').data.table
    ({label:field.title,value:field.title} for field in _.flatten getFields(table,{fields:{fields:1}}))

  valuesSelectize:->
    options:->
      query=Template.manageFilters.query.get()
      field=Template.manageFilters.selectedField.get()
      switch
        when  _.isString(field)
          console.log query.selector
          items=TableData.find(query.selector).fetch()
          ({value:data[field]} for data in items)
        else [{value:'Select field to populate!'}]
    valueField:'value'
    labelField:'value'
    searchField:'value'
    load:(search,callback)->
      console.log @
      query=Template.manageFilters.query.get()
      field=Template.manageFilters.selectedField.get()
      switch
        when _.isString field
          search="^#{search}.*$"
          query.selector[field].$regex=search
          console.log search
          Template.manageFilters.query.set query
          callback()
        else
          callback()
    maxItems:null

AutoForm.hooks
  mf:
    onSubmit:(ins,upd,curr)->
      widget=Session.get('selectedWidget')
      holder=widget.data.filters||[]
      holder.push ins
      widget.data.filters=holder
      console.log widget
      @done()
      @resetForm()
      slidePanel.showPanel 'manageWidgetItem',widget
      false
,true

AutoForm.debug()

null