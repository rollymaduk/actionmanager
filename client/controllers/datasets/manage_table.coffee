Template.manageTable.helpers
  tableObj:
    ->
      myTable=Template.currentData()
      Schema.Table.clean(myTable) if !myTable._id
      return myTable
  haslinkage:
    ->Template.currentData()?.relations?.length>=1



Template.manageTable.destroyed=->
  Myfiles.resumable.events.length=0
  Myfiles.resumable.files.length=0;

Template.manageTable.events
  'click .managelinkage':(evt,temp)->
    slidePanel.showPanel 'manageRelation',Template.currentData()


saveTable = (table,file) ->
  Meteor.call 'saveUpdateTable',table.$set._id,table,file,(err, res)->
    ###on error clean uploaded file from server###
    slidePanel.closePanel();

Template.manageTable.rendered=->
  Myfiles.resumable.on 'fileSuccess',(file)->
    table=Session.get('selectedTable')
    saveTable(table,file.uniqueIdentifier)
    return null
  return null

AutoForm.hooks
  mt:
    onSubmit:
      (ins,upd,curr)->
        upd.$set._id=curr._id
        Session.set('selectedTable',upd)

        if Myfiles.resumable.files.length>0
          for file in Myfiles.resumable.files
            do(file)->
              Myfiles.insert
                _id:file.uniqueIdentifier
                filename:file.filename
                contentType:file.file.type
                metadata:
                  file:file.uniqueIdentifier
                ,(err,id)->
                  Myfiles.resumable.upload() if !err
                  return null
              return null
        else
          table=Session.get('selectedTable')
          saveTable(table,null)
        this.done()
        return false
  ,true

AutoForm.debug()