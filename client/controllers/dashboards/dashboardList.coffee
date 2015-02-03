Template.dashboardList.created=->
  Session.set 'selectedDataset',@data

Template.dashboardList.helpers
  dashboards:
    -> Dashboards.find({dataset:Template.currentData()._id}).fetch()

Template.dashboardItem.helpers
  watchValues:->(_.random -50,150 for num in [10..1])
  options:->width:'100%',height:'120px',lineWidth:1.8,spotRadius:2,lineColor:'#3c8dbc'

Template.dashboardList.rendered=->
  $(window).on('resize', $.sparkline_display_visible())

Template.dashboardList.destroyed=->
  $(window).off('resize')