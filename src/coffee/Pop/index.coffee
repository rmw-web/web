import {Spin} from "@/coffee/Spin"
import {createApp} from 'vue'
import {camelCase} from "lodash"
import {$on} from '@/coffee/$'
import HttpSpin from '@/pkg/_/http/spin'
import "./index.styl"
spin = new Spin()

showing = undefined
export default (src)=>
  new Promise(
    (resolve)=>
      doc = document
      if showing
        return
      showing = 1
      body = doc.body
      div = doc.createElement 'dialog'
      div.className = "Pop #{camelCase src}"
      div.innerHTML = "<div><i class=X></i><main></main></div>"
      $on(
        div.querySelector('.X')
        click: =>
          div.close()
      )
      $on(
        div
        close: =>
          div.remove()
      )
      spin.inc()
      mod = import('@/pkg/'+src+'.vue')
      mod.finally spin.dec()
      mod.then (o)=>
        body.appendChild div
        showing = undefined
        d = o.default
        if d.setup?.constructor.name == 'AsyncFunction'

          d.setup().then (setup) =>
            d = {...o.default}
            d.setup = setup

            main = document.createElement('main')
            div.querySelector(".spin").replaceWith main
            app = createApp({
              render: (h) => h(d)
            })
            app.$mount main

          d = HttpSpin
        app = createApp({
          render: (h) => h(d)
        })
        app.$mount div.querySelector('main')
        if document.body.contains(div)
          div.showModal()
        resolve(app.$children[0])
  )


