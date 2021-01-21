import { addRxPlugin, createRxDatabase } from 'rxdb'

import { RxDBQueryBuilderPlugin } from 'rxdb/plugins/query-builder'
addRxPlugin(RxDBQueryBuilderPlugin)

import { RxDBUpdatePlugin } from 'rxdb/plugins/update'
addRxPlugin(RxDBUpdatePlugin)

import { RxDBValidatePlugin } from 'rxdb/plugins/validate'
addRxPlugin(RxDBValidatePlugin)

import { RxDBLeaderElectionPlugin } from 'rxdb/plugins/leader-election'
addRxPlugin(RxDBLeaderElectionPlugin)

import { RxDBReplicationPlugin } from 'rxdb/plugins/replication'
addRxPlugin RxDBReplicationPlugin

import * as PouchHttpPlugin from 'pouchdb-adapter-http'
addRxPlugin(PouchHttpPlugin)

import AdapterDb from 'pouchdb-adapter-idb'
addRxPlugin AdapterDb

class Db
  constructor:->
  $init:(@$url, schema)->

    if DEV
      { RxDBDevModePlugin } = await import('rxdb/plugins/dev-mode')
      addRxPlugin(RxDBDevModePlugin)

    @$ = $ = await createRxDatabase({
      name: 'api',
      adapter: 'idb'
      pouchSettings:
        revs_limit: 1
    })
    await $.addCollections schema

    return

export default new Proxy(
  new Db()
  get:(obj, prop)=>
    if prop.charAt(0) == "$"
      return obj[prop]

    {$} = obj
    if prop.endsWith "$"
      return (options={ live: true , retry:true })=>
        new Promise(
          (resolve)=>
            prop = prop[...-1]
            c = $[prop]
            args = {
              remote: obj.$url+prop
              options
            }
            if await $.leaderElector().elector.applyOnce()
              if options.live
                _options = {...options}
                _options.live = false
                args.options = _options
              s = c.sync args
              s.complete$.subscribe (done) =>
                if done
                  args.options = options
                  resolve c.sync args
            else
              resolve c.sync args

        )
    return $[prop]

)

# export default = =>
#
#   db.items.find().$.subscribe (li)=>
#     for i from li
#       console.log i.key, i.value, i
