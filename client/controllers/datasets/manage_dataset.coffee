Template.manageDataset.created=->
  Session.set('selectedDataset',this.data)

Template.tableview.events
  'click .edit-table':(evt,temp)->
    slidePanel.showPanel('manageTable',Template.currentData())
  'click .load-data':(evt,temp)->
    Tables.update(Template.currentData()._id,{$set:{isProcessing:true}})
    Meteor.call 'uploadFileToDb',Template.currentData()._id,(err,res)->
      Tables.update(temp.data._id,{$set:{isProcessing:false}})
      null
    null
  'click .remove-table':(evt,temp)->

Template.tableview.helpers
  hasfile:->
    file=Myfiles.findOne({'metadata.table':Template.currentData()._id})
    !_.isEmpty(file)




###Template.unloadedTable.helpers
  isProcessing:
    ->Template.currentData().isProcessing=='t'###

Template.tablesFooter.helpers
  beforeRemove:->
    (coll,id)->
      _self=@;
      EZModal
        title:'Delete'
        body: 'Are you sure?'
        rightButtons:[
          color: 'danger'
          html:'delete'
          fn:(e,tmp)->
            _that=@
            ###remove all linkages and data here###
            Meteor.call 'removeTableFromDb',id
            ,(err,res)->
              if !err
                _self.remove()
                _that.EZModal.modal('hide')
                null
            null
        ]
      null

Template.manageDataset.helpers
  selectedDataset:
    -> Template.currentData()
  tables:
    ->Tables.find({dataset:Template.instance().data._id})

Autoform.addHooks null,before:->
