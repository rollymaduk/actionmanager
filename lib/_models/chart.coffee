Schema.Chart=new SimpleSchema
  type:
    type:String
    allowedValues:["line", "spline","step","area", "area-spline","area-step","bar","scatter","pie","donut","gauge"]
  data:
    type:Object
    blackbox:true
    optional:true
    autoform:
      type:'hidden'
      label:false
  'axis.x':
    type:Object
    autoform:
      template:'chartAxisMode'
  'axis.x.type':
    label:'Mode'
    type:String
    allowedValues:["indexed","category","timeseries"]
    defaultValue:"indexed"
    autoform:
      noselect:'radio'
