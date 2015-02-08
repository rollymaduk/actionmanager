Template.afArrayField_aggregationValues.helpers
  valuesSelectize:->
    options:->
      ({label:field.title,value:field.title} for field in _.flatten getFields(Session.get('selectedTablekey'),{fields:{fields:1}}))
    valueField:'value'
    labelField:'label'
    maxItems:null