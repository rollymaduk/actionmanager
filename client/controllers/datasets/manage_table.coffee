Template.manageTable.helpers
  tableObj:
    ->
      myTable=Template.currentData()
      Schema.Table.clean(myTable)
      return myTable

AutoForm.hooks
  mt:
    onSubmit:
      (ins,upd,curr)->
        dataset=Session.get('selectedDataset')
        switch
          when curr.isSaved then (table=ins for table in dataset.tables when table.title is curr.title)
          else
            dataset.tables.push(ins)
            Session.set('selectedDataset',dataset)
            slidePanel.closePanel()
        this.done()
        return false
  ,true

AutoForm.debug()