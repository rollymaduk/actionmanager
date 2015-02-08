Template.dashboard_main.rendered=
  ->
    $.getScript('/js/app.js',(x,y,z)->console.log 'loaded script successfully!SS')
    slidePanel.overlay(true)
    return null