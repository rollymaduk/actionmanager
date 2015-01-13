@Datasets=new Meteor.Collection('datasets')
Datasets.attachSchema Schema.Dataset
Datasets.allow
  insert:(user,doc)-> true
  remove:(user,doc)-> true
  update:(user,doc,fields,modifier)->true