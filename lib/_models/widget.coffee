Schema.FilterSchema=new SimpleSchema
  groupOperator:
    type:String
    defaultValue:'$and'
    allowedValues:
      ['$and','$or']
    autoform:
      options:[
        {label:'and',value:'$and'}
        {lable:'or',value:'$or'}
      ]
  field:
    type:String
  operator:
    type:String
    allowedValues:
      ['none','$gt','$gte','$in','$lt','$lte','$ne','$nin']
    autoform:
      options:[
        {label:'equal',value:'none'}
        {label:'greater than',value:'$gt'}
        {label:'greater or equal',value:'$gte'}
        {label:'contains',value:'$in'}
        {label:'less than',value:'$lt'}
        {label:'less or equal',value:'$lte'}
        {label:'not equal',value:'$ne'}
        {label:'does not contain',value:'$nin'}
      ]
  value:
    type:[String]


Schema.ValueSchema=new SimpleSchema
  name:
    label:"Value title"
    type:String
    defaultValue:'count'
  aggregate:
    type:String
    allowedValues:['$avg','$sum','$min','$max','none']
    defaultValue:'none'
    autoform:
      options:[
        {label:"Average",value:'$avg'}
        {label:"Sum",value:'$sum'}
        {label:"Max",value:'$max'}
        {label:"Min",value:'$min'}
        {label:"Count",value:'none'}
      ]
  operator:
    type:String
    defaultValue:'none'
    allowedValues:["none","$multiply","$add","$divide","$subtract"]
    autoform:
      options:[
        {label:'None',value:'none'}
        {label:'Multiply',value:'$multiply'}
        {label:'Add',value:"$add"}
        {label:'Divide',value:"$divide"}
        {label:'Subtract',value:"$subtract"}
        ]
  values:
    type:[String]
    defaultValue:[]


Schema.Widget=new SimpleSchema
  dashboard:
    type:String
    autoform:
      type:'hidden'
  title:
    type:String
  type:
    type:String
    allowedValues:['chart','table','filter','collaboration']
  'data.table':
    type:String
  'data.group':
    label:"Group by"
    type:String
  'data.filters':
    defaultValue:[]
    type:[Schema.FilterSchema]
  'data.values':
    defaultValue:[]
    type:[Schema.ValueSchema]

  widget:
    type:Object
    blackbox:true
    autoform:
      type:'hidden'
      label:false
