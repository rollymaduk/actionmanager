Meteor.methods
  getAggregateData:(pipeline)->
    try
      return TableData.aggregate pipeline
    catch
      throw new Meteor.Error 'failed to get data'
