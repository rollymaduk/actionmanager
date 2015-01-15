Template.manageDataset.created=->
  Session.set 'selectedDataset',this.data

Template.manageDataset.helpers
  selectedDataset:
    -> Session.get 'selectedDataset'