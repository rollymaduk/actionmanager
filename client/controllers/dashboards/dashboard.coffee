Template.dashboard.created=->
  Session.set('selectedDashboard',@.data)

Template.dashboard.helpers
  widgets:->


Template.dashboard.rendered=->
  grid=Template.dashboard.initialize()
  cursor=Widgets.find({dashboard:@.data._id})
  cursor.observe
    added:(doc)->
      grid.add_widget "<div class='grid-stack-item'>
        <div class='grid-stack-item-content' id='#{doc._id}' /></div>"
      ,0,0,1,1,true
      domObj=Template.instance().$("##{doc._id}")[0]
      Blaze.renderWithData Template.chartWidget,doc,domObj
      null
  null

Template.dashboard.options=
  cell_height: 80,
  vertical_margin: 10
  animate:true

Template.dashboard.initialize=->
 Template.instance().$(".grid-stack").gridstack(@options)
 Template.instance().$(".grid-stack").data('gridstack')
