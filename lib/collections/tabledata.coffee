@TableData=new Meteor.Collection('tabledata')
TableData.allow
  insert:(usr,doc)->true
  update:(usr,doc,field,modifier)->true
  remove:(usr,doc)->true