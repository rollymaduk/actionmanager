@getTables=(query...)->
  Tables.find(query[0],query[1])

@getFields=(query...)->
  getTables(query...).map (table)->table.fields
