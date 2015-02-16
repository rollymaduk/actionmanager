Meteor.publish 'tabledata',(query,limit)->
  limit=limit||50
  query=query||{}
  TableData.find(query,{limit:limit})