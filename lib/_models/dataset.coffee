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
  fields:
    type:[Schema.Field]
)
Schema.Dataset=new SimpleSchema(
  title:
    type:String
    max:200
  tables:
    type:[Schema.Table]
    optional:true
)



