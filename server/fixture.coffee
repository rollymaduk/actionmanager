Meteor.startup ->
  Datasets.insert @testData unless Datasets.find().count() isnt 0
  return null