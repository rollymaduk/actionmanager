@Tables=new Meteor.Collection('tables')
Tables.attachSchema Schema.Table
Tables.allow
  insert:(user,doc)->true
  remove:(user,doc)->true
  update:(user,doc,fields,modifier)->true