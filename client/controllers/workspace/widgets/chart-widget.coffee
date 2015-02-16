Template.chartWidget.created=->
  Template.chartWidget.prepareFilters(@data.data.table)
  Template.chartWidget.prepareGroups(@data.data.group)
  Template.chartWidget.prepareChartData(@data)

Template.chartWidget.rendered=->

Template.chartWidget.initializeFilters =(filter)->
  operator = {}
  value = {}
  switch
    when filter.operator isnt 'none'
      operator[filter.operator]=if filter.operator is '$in' then filter.value
      else filter.value[0]
      null
    else
      operator = filter.value[0]
      null
  value[filter.field] = operator

  filters=@getFilters()
  if _.isArray(filters[filter.groupOperator])
    filters[filter.groupOperator].push(value)
    @setFilters(filters)
    null
  else
    if _.isEmpty(filters)
      @setFilters(value)
      null
    else
      clone=_.clone(filters)
      item={}
      item[filter.groupOperator]=[clone, value]
      @setFilters(item)
      null
    null
  console.log @getFilters()

Template.chartWidget.initializeGroups=(val)->
  group=@getGroups()
  accumulator={}
  operator={}
  values=("$#{item}" for item in val.values)
  if val.operator isnt 'none'
    operator[val.operator]=values
  else operator=values[0]
  if val.aggregate isnt 'none' then accumulator[val.aggregate]=operator else accumulator['$sum']=1
  group[val.name]=accumulator
  @setGroups(group)
  console.log @getGroups()



Template.chartWidget.prepareChartData=(widget)->
  @initializeFilters(filter) for filter in widget.data.filters
  @initializeGroups(group) for group in widget.data.values
  pipeline=[{$match:@getFilters()},{$group:@getGroups()}]
  Meteor.call 'getAggregateData', pipeline,(err,res)->
    if res then console.log res else console.log err
  ###console.log pipeline###
  ###Meteor.apply###


Template.chartWidget.getGroups=->
  @getData().myGroups or false

Template.chartWidget.setGroups=(groups)->
  Match.test groups,Object
  @setData('myGroups',groups)

Template.chartWidget.getFilters=->
  @getData().myfilters or false

Template.chartWidget.setFilters=(filters)->
  Match.test filters,Object
  @setData('myfilters',filters)

Template.chartWidget.prepareFilters=(table)->
  filters=@getFilters()
  unless filters
    filters={table:table}
  @setFilters filters

Template.chartWidget.prepareGroups=(group)->
  groups=@getGroups()
  unless groups
    groups={_id:"$#{group}"}
  @setGroups groups


###utility methods###
Template.chartWidget.getData=->
  Template.currentData()

Template.chartWidget.setData=(key,value)->
  Template.currentData()[key]=value
