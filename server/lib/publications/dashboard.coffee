Meteor.publish 'dashboards', (id)->
  Dashboards.find(id)