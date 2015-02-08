Schema.ValueSchema=new SimpleSchema
  name:
    type:String
    defaultValue:'count'
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
        {label: 'Subtract',value:"$subtract"}
        ]
  values:
    type:[String]
    optional:true


Schema.Widget=new SimpleSchema
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
  'data.values':
    type:[Schema.ValueSchema]
  'data.aggregate':
    type:String
    allowedValues:['$avg','$sum','none']
    autoform:
      options:[
        {label:"Average",value:'$avg'}
        {label:"Sum",value:'$sum'}
        {label:"Count",value:'none'}
      ]
  widget:
    type:Object
    blackbox:true
    autoform:
      type:'hidden'
      label:false
