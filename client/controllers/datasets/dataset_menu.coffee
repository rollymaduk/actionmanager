Template.datasetTables_menu.events
  'click #addtable':
    (ev,temp)->
      slidePanel.showPanel('dataloadSelection')
      return null

Template.datasetDashboard_menu.events
  'click #addDashboard':
    (evt,temp)->
      slidePanel.showPanel('createDashboard')
