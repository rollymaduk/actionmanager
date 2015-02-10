setFieldsForTable=(table)->
  fields=({label:field.title,value:field.title} for field in _.flatten getFields(table,{fields:{fields:1}}))
  Template.manageWidgetItem.fields.set(fields)

Template.manageWidgetItem.created=->
  ###console.log @data###
  Template.manageWidgetItem.fields=new ReactiveVar()
  bigSubs.subscribe('datasetItem',Session.get("selectedDashboard").dataset)

Template.manageWidgetItem.rendered=->
  setFieldsForTable(AutoForm.getFieldValue('wf','data.table'))

Template.manageWidgetItem.destroyed=->
  console.log 'destroyed'

Template.manageWidgetItem.events
  "change select[data-schema-key='data.table']":(evt,temp)->
    Session.set('selectedTablekey',evt.target.value)
    setFieldsForTable(evt.target.value)

  "click .manage-values":(evt,temp)->
    widget=AutoForm.getFormValues('wf').insertDoc
    widget.data.values=temp.data.data.values
    Session.set('selectedWidget',widget)
    valObj={}
    Schema.ValueSchema.clean valObj
    slidePanel.showPanel 'manageValues',valObj


Template.manageWidgetItem.helpers
  widgetObj:->Template.currentData()
  formType:-> if Template.currentData()._id then 'update' else 'insert'
  tables:->
    getTables({dataset:Session.get("selectedDashboard").dataset},{fields:title:1}).map (table)->{label:table.title,value:table._id}
  groups:->Template.manageWidgetItem.fields.get()
  values:->
    console.log Template.currentData()
    Template.currentData()?.data?.values
  tableIsSelected:->
    _.isString(AutoForm.getFieldValue('wf','data.table'))

