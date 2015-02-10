Template.manageValues.helpers
  valuesSelectize:->
    options:->
      table=Session.get('selectedWidget').data.table
      ({label:field.title,value:field.title} for field in _.flatten getFields(table,{fields:{fields:1}}))
    valueField:'value'
    labelField:'label'
    maxItems:null

AutoForm.hooks
  mv:
    onSubmit:(ins,upd,curr)->
      widget=Session.get('selectedWidget')
      holder=widget.data.values||[]
      holder.push ins
      widget.data.values=holder
      console.log widget
      @done()
      slidePanel.showPanel 'manageWidgetItem',widget
      false
  ,true

AutoForm.debug()

null
