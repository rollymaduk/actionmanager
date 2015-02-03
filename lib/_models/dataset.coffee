Schema.Field=new SimpleSchema(
  title:
    type:String
  alias:
    type:String
    optional:true
  isVisible:
    type:Boolean
    defaultValue:true
)

Schema.Relation=new SimpleSchema
  table:
    type:String
  from:
    type:String
  to:
    type:String

Schema.Table=new SimpleSchema(
  title:
    type:String
    autoform:
      label:false
      afFieldInput:
        type:'contenteditable'
  dataset:
    type:String
    defaultValue:''
    autoform:
      label:false
      type:'hidden'
  fields:
    type:[Schema.Field],
  isProcessing:
    type:Boolean
    optional:true
    defaultValue:false
    autoform:
      label:false
      type:'hidden'
  relations:
    type:[Schema.Relation]
    optional:true
    defaultValue:[]

)
Schema.Dataset=new SimpleSchema(
  title:
    type:String
    max:200


)



