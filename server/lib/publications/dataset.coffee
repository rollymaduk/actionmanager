Meteor.publish  "datasetList",-> Datasets.find({},{fields:{title:1}})

Meteor.publish  "datasetItem",(datsetId)->
  Publish.relations @,Datasets.find(datsetId),(id,doc)->
    @cursor Tables.find({dataset:id}),(id,doc)->
      doc.hasfile=this.changeParentDoc(Myfiles.find({'metadata.table':id},{fields:{'metadata.file':1}})
      ,(file)->
        !_.isEmpty(file)
      ,(file)->
        !_.isEmpty(file))
      doc.hasfile=false if !_.isBoolean(doc.hasfile)
      ### @cursor Myfiles.find({'metadata.table':id}),(id,doc)->###
      null
    null
  return this.ready()