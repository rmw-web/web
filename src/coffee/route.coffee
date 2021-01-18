if DEV
  import('./dev')

# 这个不能import，必须require，不然会被摇树优化掉
require "@/coffee/a"

import {TITLE} from "@/coffee/title"
import {Spin} from "@/coffee/Spin"
import $state from '@/coffee/$/state'
import HttpSpin from '@/pkg/_/http/spin'
import {onBeforeMount} from 'vue'

spin = new Spin()
pwd = _page = undefined

export route = (uri)=>
  if pwd == uri
    return
  spin.inc()
  pwd = uri
  _page.i.value = HttpSpin
  `import('../pkg/'+uri)`.then(
    (p)=>
      if uri == pwd
        document.title = TITLE
        d = p.default
        _page.i.value = d
      return
    (err)=>
      alert " 出错了 : "+err
  ).finally spin.end.bind(spin)

export default (prefix, page)=>
  _page = page
  prefix_vue = prefix+"/vue/"
  url = require("@/pkg/"+prefix+"/coffee/url").default
  goto = =>
    #regexp = pathToRegexp("test/(\\d+)/(\\d+)")
    uri = url location.pathname[1..]

    if uri.startsWith("/")
      uri = uri.slice(1)
    else
      uri = prefix_vue + uri
    route uri
  goto()
  # navigator.serviceWorker.addEventListener(
  #   "message"
  #   =>
  #     if pwd?.startsWith 'auth/'
  #       if pwd!='auth/vue/_empty'
  #         return
  #     pwd = undefined
  #     page.i.value = HttpSpin
  #     goto()
  # )
  $state goto
    # pushState:goto
    # popstate:goto
    # popstate:=>
    # popstate:=>
    #   for i in document.querySelectorAll('.X')
    #     i.click()
    #   goto()
  # }
  page
