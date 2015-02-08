Template.manageWidgetItem.created=->
  Session.set('selectedWidget',@data)
  Template.manageWidgetItem.fields=new ReactiveVar([])
  bigSubs.subscribe('datasetItem',Session.get("selectedDashboard").dataset)


Template.manageWidgetItem.events
  "change select[data-schema-key='data.table']":(evt,temp)->
    Session.set('selectedTablekey',evt.target.value)
    fields=({label:field.title,value:field.title} for field in _.flatten getFields(evt.target.value,{fields:{fields:1}}))
    console.log fields
    Template.manageWidgetItem.fields.set(fields)
  "click manage-values":(evt,temp)->
    slidePanel.showPanel 'manageValues',{name:"new value"}


Template.manageWidgetItem.helpers
  widgetObj:->Template.currentData()
  formType:-> if Template.currentData()._id then 'update' else 'insert'
  tables:->
    getTables({dataset:Session.get("selectedDashboard").dataset},{fields:title:1}).map (table)->{label:table.title,value:table._id}
  groups:->Template.manageWidgetItem.fields.get()
  values:-> Template.currentData().data.values
