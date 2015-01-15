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
Schema.Table=new SimpleSchema(
  title:
    type:String
    autoform:
      label:false
      afFieldInput:
        type:'editable-input'
  fields:
    type:[Schema.Field]
  isSaved:
    type:Boolean
    defaultValue:false
    autoform:
      label:false
      afFieldInput:
        type:'hidden'

)
Schema.Dataset=new SimpleSchema(
  title:
    type:String
    max:200
  tables:
    type:[Schema.Table]
    defaultValue:[]

)



