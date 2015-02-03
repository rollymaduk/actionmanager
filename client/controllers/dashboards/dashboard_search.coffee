Template.dashboardSearch.rendered=->
  @dashSearch=$('.dashSearch').reactiveSelectize(
    options:-> Dashboards.find()
    valueField:'_id'
    labelField:'title'
    maxItems:1
    sortField:'title'
    persist:false
    searchField:['title']
  )[0].reactiveSelectize
###Template.dashboardSearch.helpers
  dashboardsSelectize:->
    options:->Dashboards.find().fetch()
    valueField:'_id'
    labelField:'title'###

Template.dashboardSearch.events
  'change #dashSearch':(evt,tpl)->
