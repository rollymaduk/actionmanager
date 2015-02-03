Schema.WidgetSchema=new SimpleSchema
  title:
    type:String
    optional:true

Schema.Dashboard=new SimpleSchema
  title:
    type:String
  widgets:
    type:[Schema.WidgetSchema]
    optional:true
    defaultValue:[]
  dataset:
    type:String
    autoform:
      label:false
      type:'hidden'

