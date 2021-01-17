import "../styl/init"
import TITLE from '../config/title.txt'
import Ws from '@/coffee/ws'
import {createApp} from 'vue'
import url from '../vue/_/url'
import Db from '@/db/rxdb'
import {schema} from "@/ws/rxdb"
import RXDB_URL from "@/config/rxdb.txt"

do =>
  ws = Ws()

  document.title = TITLE
  div = document.createElement 'main'
  document.body.appendChild div
  await Db.$init(
    RXDB_URL
    await schema()
  )
  createApp(url).mount(div)


  # state.change$.subscribe (change) =>
  #   console.log 'Replication change', change
  #   console.dir(change)
  #
  # state.active$.subscribe (change) =>
  #   console.log "active"
  #   for i from await db.items.find().exec()
  #     console.log i.key, i.value


# import VueCompositionApi from 'vue/composition-api'
#
# Vue.use(VueCompositionApi)
#
# VUE = require('../vue/route').default
#
# import runtime from 'serviceworker-webpack-plugin/lib/runtime'
#
# do =>
#   render = =>
#     require '@/pkg/auth/coffee/login'
#     new Vue({
#       render: (h) => h(VUE)
#     }).$mount(div)
#
#   reg = await runtime.register()
#   sw = reg.active or reg.installing
#   activated = 'activated'
#   statechange = 'statechange'
#   if sw.state != activated
#     _state = (e)->
#         if @state == activated
#           render()
#           sw.removeEventListener statechange, _state
#     sw.addEventListener statechange, _state
#   else
#     if navigator.serviceWorker.controller
#       render()
#     else
#       location.reload()
#   import('@/coffee/onload')
# #   if reg.installing
# #     reg.installing.onstatechange = (event) ->
# #       console.log @state
# #       if @state == 'activated'
# #         setTimeout render
# #         console.log navigator.serviceWorker.controller
# #   else
# #     render()
# #
# #
# # # component = ->
# # #   console.log "1"
# # #   element = document.createElement('p')
# # #   element.innerHTML = join([
# # #     'h2'
# # #     'webpack'
# # #   ], ' ')
# # #   element
# #
# # # document.body.appendChild component()
