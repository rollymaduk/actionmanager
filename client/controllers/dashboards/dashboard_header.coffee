Template.dashboard_header.events
  'click .add-widget':(evt,temp)->
    slidePanel.showPanel('widgetSelection',temp.data)