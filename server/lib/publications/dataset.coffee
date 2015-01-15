Meteor.publish  "datasetList",-> Datasets.find({},{fields:{title:1}});
Meteor.publish  "datasetItem",(id)-> Datasets.find({_id:id});