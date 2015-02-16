setFieldsForTable=(table)->
  fields=({label:field.title,value:field.title} for field in _.flatten getFields(table,{fields:{fields:1}}))
  Template.manageWidgetItem.fields.set(fields)

setWidgetExtraValues = (widget, data) ->
  widget.data.values = data.data.values
  widget.data.filters = data.data.filters
  widget.dashboard=data.dashboard
  widget.widget = data.widget

getCurrentWidget=(data)->
  widget=AutoForm.getFormValues('wf').insertDoc
  setWidgetExtraValues(widget, data)
  widget

Template.manageWidgetItem.created=->
  console.log @data
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
    widget=getCurrentWidget(temp.data)
    Session.set('selectedWidget',widget)
    valObj={}
    Schema.ValueSchema.clean valObj
    slidePanel.showPanel 'manageValues',valObj

  'click .manage-filters':(evt,temp)->
    widget=getCurrentWidget(temp.data)
    Session.set('selectedWidget',widget)
    valObj={}
    Schema.FilterSchema.clean valObj
    slidePanel.showPanel 'manageFilters',valObj


Template.manageWidgetItem.helpers
  widgetObj:->Template.currentData()
  formType:-> if Template.currentData()._id then 'update' else 'insert'
  tables:->
    getTables({dataset:Session.get("selectedDashboard").dataset},{fields:title:1}).map (table)->{label:table.title,value:table._id}
  groups:->Template.manageWidgetItem.fields.get()
  filters:->Template.currentData()?.data?.filters
  values:->Template.currentData()?.data?.values
  tableIsSelected:->
    _.isString(AutoForm.getFieldValue('wf','data.table'))

AutoForm.hooks
  wf:
    before:
      insert:(doc,temp)->
        setWidgetExtraValues(doc, temp.data.doc)
        console.log temp.data
        console.log doc
        @result(doc)
        null
    onSuccess:(op,res,temp)->
      slidePanel.closePanel()
  ,true

AutoForm.debug()