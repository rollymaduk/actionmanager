Template.widgetSelection.created=->
  @type=new ReactiveVar(null);

Template.widgetSelection.events
  'click .addwidget':(evt,temp)->
    type= evt.target.dataset.type
    temp.type.set(type)
    ### slidePanel.showPanel 'widgetSelection',type###

Template.widgetSelection.helpers
  widgetSchema:->
    switch Template.instance().type.get()
      when 'chart' then 'Schema.Chart'
      when 'collaboration' then 'Schema.Collaboration'
      when 'filter' then 'Schema.Filter'
      else 'Schema.Table'
  type:->Template.instance().type.get()

Template.widgetSelection.rendered=->
  self=@
  AutoForm.hooks
    nw:
      onSubmit:(ins,upd,doc)->
        ###move chart obj to main widget###
        type=self.type.get()
        widget={title:"new #{type}",type:type}
        slidePanel.showPanel 'manageWidgetItem',widget
        @done()
        false
    ,true
