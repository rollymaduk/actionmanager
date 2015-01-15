@bigSubs=new SubsManager({cacheLimit: 9999, expireIn: 9999});

Router.configure {layoutTemplate:'main',yieldTemplates:{'sidebar':{to:'sidebar'}}}


Router.map ()->
  this.route('home',path:'/',
  onBeforeAction:
      ->
        setPage("Home",'client name','datasetList_menu')
        this.next()
  ,waitOn:
      ->
        bigSubs.subscribe('datasetList')

  )


  this.route('manage-dataset',path:'/dataset/:_id',
  data:
    ->
      return Datasets.findOne(@params._id)
  ,onBeforeAction:
    ->
      setPage('Manage','client name','datasetTables_menu')
      this.next()
  ,waitOn:-> bigSubs.subscribe('datasetItem',@params._id)
  )
  return null
