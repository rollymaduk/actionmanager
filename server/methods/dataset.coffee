loadDb=(filestream,filelink)->
  ###parser=Csv({json:true})###
  ###count=1###
  res=Async.runSync (done)->
        parser=Csv({json:true})
        count=0
        filestream.pipe parser
        .on 'data',Meteor.bindEnvironment (data)->
          data.table=filelink
          data.isNew=true
          console.log data
          count++
          TableData.insert data
          null
        ,(e)->done(e,null)
        .on 'error',Meteor.bindEnvironment (err)->
          console.log 'error struck here!'
          done(err,null)
          null
        .on 'end',Meteor.bindEnvironment ()->
          console.log 'ended upload'
          inserted=TableData.find({table:filelink,isNew:true}).count()
          switch
            when inserted isnt count then TableData.remove {table:filelink,isNew:true}
            else
              TableData.update {table:filelink,isNew:true}, {$set:isNew:false},multi:true
              Myfiles.remove {'metadata.table':filelink} if inserted > 0

          str="#{ inserted } #{ count }"
          done(null,str)

          ###Myfiles.remove({metadata:{table:filelink}})###
          ###Myfiles.remove({metadata:{table:filelink}})###
        ,(e)->
          done(e,null)
          null
        null
  res

Meteor.methods
  saveUpdateTable:(id,table,file_id)->
    res=Tables.upsert id,table
    upd=Myfiles.update({metadata:{file:file_id}},{$set:{'metadata.table':res.insertedId}}) if res.insertedId
    res

  uploadFileToDb:(filelink)->
    filestream=Myfiles.findOneStream({'metadata.table':filelink})
    switch
      when filestream then loadDb filestream,filelink
      else
        throw new Meteor.Error 'file does not exist'






