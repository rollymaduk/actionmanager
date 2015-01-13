@setPage =(options...)=>
  Session.set "pagetitle",options[0]
  Session.set "subtitle",options[1]
  Session.set "pagemenu",options[2]
  return null