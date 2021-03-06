Template.dataloadSelection.created=->
  @dataTitle=new ReactiveVar("New Table")

Template.dataloadSelection.destroyed=->
  Myfiles.resumable.events.length=0

Template.dataloadSelection.rendered=->
  that=@
  Myfiles.resumable.assignBrowse $(".fileBrowse")
  Myfiles.resumable.on 'fileAdded'
    ,(file)->
      Papa.parse file.file,
         preview:5
         header:true
         complete:(res,file)->
          fields=({title:field,alias:field} for field in res.meta.fields)
          newTable=title:that.dataTitle.get(),fields:fields,dataset:Session.get('selectedDataset')._id
          slidePanel.showPanel('manageTable',newTable)
          return null
      return null
  return null