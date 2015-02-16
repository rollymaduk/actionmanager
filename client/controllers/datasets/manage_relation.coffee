Template.manageRelation.created=->
  Session.set 'selectedTable',@data

Template.manageRelation.helpers
  table:()->
    Template.currentData();

Template.relatedColumn.created=->
  console.log @
  @tofields=new ReactiveDict()




Template.relatedColumn.helpers
  tables:()->
    table=Session.get('selectedTable')._id
    tables=Tables.find({$and:[{dataset:Session.get('selectedDataset')._id},{_id:{$ne:table}}]},{fields:{title:1}}).fetch()
    ({label:table.title,value:table._id} for table in tables)

  from:->
    table= Session.get('selectedTable')._id
    fields=({label:field.title,value:field.title} for field in _.flatten getFields(table,{fields:{fields:1}}))
    fields


  to:->
    console.log Template.instance()
    console.log @
    Template.instance().tofields.get(@name)
    ###Template.instance().tofields[@name].get()###



Template.relatedColumn.events
  "change .linktbl":(evt,temp)->
    table=evt.target.value
    fields=({label:field.title,value:field.title} for field in _.flatten getFields(table,{fields:{fields:1}}))
    temp.tofields.set(temp.data.name,fields)
    ###Template.afArrayField.tofields[].set(fields)###


AutoForm.hooks
  mr:
    after:
      update:
        (err,res,temp)->
          switch
            when err then console.log(err)
            else
              this.resetForm()
              slidePanel.closePanel()

  ,true


AutoForm.debug()