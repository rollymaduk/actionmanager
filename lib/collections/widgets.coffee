@Widgets=new Meteor.Collection 'widgets'
Widgets.attachSchema Schema.Widget
Widgets.allow
  insert:(user,doc)->true
  remove:(user,doc)->true
  update:(user,doc,fields,modifier)->true