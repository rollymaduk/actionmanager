Template.main.rendered=
  ->
    $.getScript('js/app.js')
    slidePanel.overlay(true)
    return null

Template.main.helpers
  pagetitle:
    ->Session.get('pagetitle')
  subtitle:
    ->Session.get('subtitle')
  pagemenu:
    ->Session.get('pagemenu')