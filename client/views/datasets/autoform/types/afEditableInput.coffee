
Template.afEditableInput.created=
  ->
    this.editval=new ReactiveVar(this.data.value)


Template.afEditableInput.helpers
  options:->
    inst=Template.instance();
    selector="[name='#{this.name}']"
    type:'text'
    value:inst.editval.get()
    position:'right'
    onsubmit:(itm)=>
      $(selector).val(itm)
      inst.editval.set(itm)
      return null



AutoForm.addInputType 'editable-input',
  template:'afEditableInput'
  valueOut:->return this.val()
return null



