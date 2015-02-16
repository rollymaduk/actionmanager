Meteor.publish 'dashboards', (dashid)->
  Publish.relations @,Dashboards.find(dashid),(id,doc)->
    @cursor Widgets.find({dashboard:id}),(id,doc)->
    null
  return this.ready()

