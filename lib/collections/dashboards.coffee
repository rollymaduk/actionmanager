@Dashboards=new Meteor.Collection 'dashboards'
Dashboards.attachSchema Schema.Dashboard
Dashboards.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true

