Template.manageRelation.helpers
  table:()->
    Template.currentData();

Template.afArrayField_tableRelation.helpers
  tables:()->
    tables=Tables.find({dataset:Session.get('selectedDataset')._id},{fields:{title:1}}).fetch()
    ({label:table.title,value:table._id} for table in tables)

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