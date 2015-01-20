Template.manageDataset.created=->
  Session.set 'selectedDataset',this.data

Template.tableview.events
  'click .edit-table':(evt,temp)->
    slidePanel.showPanel('manageTable',temp.data)
  'click .remove-table':(evt,temp)->

Template.unloadedTable.events
  'click .load-data':(evt,temp)->
    ###Tables.update(Template.currentData()._id,{$set:{isProcessing:'t'}})###
    Meteor.call 'uploadFileToDb',Template.currentData()._id,(err,res)->
      Tables.update Template.currentData()._id,{$set:{isProcessing:'f'}}
      null
    null

Template.unloadedTable.helpers
  isProcessing:
    ->Template.currentData().isProcessing=='t'


Template.manageDataset.helpers
  selectedDataset:
    -> Template.currentData()
  tables:
    ->Tables.find({dataset:Template.instance().data._id})