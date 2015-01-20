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
  dataset:
    type:String
    defaultValue:''
    autoform:
      label:false
      type:'hidden'
  fields:
    type:[Schema.Field],
  source:
    type:String
    defaultValue:'excel'
    autoform:
      type:'hidden'
      label:false
  isProcessing:
    type:String
    defaultValue:'f'
    autoform:
      label:false
      type:'hidden'

)
Schema.Dataset=new SimpleSchema(
  title:
    type:String
    max:200


)



