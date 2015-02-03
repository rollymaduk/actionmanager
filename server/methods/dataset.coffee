loadDb=(filestream,table_link)->
  ###parser=Csv({json:true})###
  ###count=1###
  res=Async.runSync (done)->
        parser=Csv({json:true})
        count=0
        filestream.pipe parser
        .on 'data',Meteor.bindEnvironment (data)->
          data.table=table_link
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
          inserted=TableData.find({table:table_link,isNew:true}).count()
          switch
            when inserted isnt count
              TableData.remove {table:table_link,isNew:true}
              done('invalid insert',null)
              null
            else
              TableData.update {table:table_link,isNew:true}, {$set:isNew:false},multi:true
              Myfiles.remove {'metadata.table':table_link} if inserted > 0
              done(null,rows:inserted,table:table_link)
              null
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
  removeTableFromDb:(table_id)->
    TableData.remove {table:table_id}

  uploadFileToDb:(table_link)->
    filestream=Myfiles.findOneStream({'metadata.table':table_link})
    switch
      when filestream
        res=loadDb filestream,table_link
        switch
          when res.error then throw new Meteor.Error res.Error
          else
            res.result
      else
        throw new Meteor.Error 'file does not exist'






