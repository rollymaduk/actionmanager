@Myfiles= new FileCollection 'myfiles'
  ,resumable:true
    ,http:[
            method: 'get',
            path: '/:md5',
            lookup: (params, query)->return  md5: params.md5
]
Myfiles.allow
  insert:(userid,file)->return true
  remove:(userid,file)->return true
  read:(userid,file)->return true
  write:(userid,file,fields)->return true