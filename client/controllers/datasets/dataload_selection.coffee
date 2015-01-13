Template.dataloadSelection.rendered=->
  console.log "here to stay!"
  Myfiles.resumable.assignBrowse $(".fileBrowse")
  Myfiles.resumable.on 'fileAdded',(file)->
  return null