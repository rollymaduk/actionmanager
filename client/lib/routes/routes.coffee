@bigSubs=new SubsManager({cacheLimit: 9999, expireIn: 9999});

Router.configure {layoutTemplate:'main'}

Router.map ()->
  this.route('home',path:'/',
  onAfterAction:
      ->
        setPage("Home",'client name','datasetList_menu')
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
  ,waitOn:
    ->
      bigSubs.subscribe('datasetItem',@params._id)
      bigSubs.subscribe('tabledata')

  )

  this.route 'dashboardList',path:'/dashboards/:_id',
  data:
    ->return Datasets.findOne(@params._id)

  ,onAfterAction:
    ->setPage('Dashboards','client','datasetDashboard_menu')
  ,waitOn:
    ->bigSubs.subscribe('dashboardsByDataset',@params._id)

  this.route 'dashboard',path:'/dashboard/:_id',
  data:
    ->return Dashboards.findOne(@params._id)
  ,onAfterAction:
    ->
      # set title for dashboard here#####
      @layout 'dashboard_main'
  ,waitOn:
    ->bigSubs.subscribe('dashboards',@params._id)
  return null
