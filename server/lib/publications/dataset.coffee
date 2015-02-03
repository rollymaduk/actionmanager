Meteor.publish  "datasetList",-> Datasets.find({},{fields:{title:1}})

Meteor.publish  "datasetItem",(datsetId)->
  Publish.relations @,Datasets.find(datsetId),(id,doc)->
    @cursor Tables.find({dataset:id}),(id,doc)->
      @cursor Myfiles.find({'metadata.table':id},{fields:'metadata.table':1}),(id,doc)->
      null
    null
  return this.ready()

Meteor.publish  "dashboardsByDataset",(datsetId)->
  Publish.relations @,Datasets.find(datsetId),(id,doc)->
    @cursor Dashboards.find({dataset:id}),(id,doc)->
    null
  return this.ready()