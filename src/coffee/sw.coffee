localforage = require 'localforage'
uuidv4 = require 'uuid/v4'
import {encode} from 'z85'

ME = undefined

self.addEventListener(
  'activate'
  (event) =>
    event.waitUntil(clients.claim())
)

self.addEventListener(
  'install'
  (event)=>
    event.waitUntil(skipWaiting())
)

_token = =>
  token = 'token'
  i = await localforage.getItem token
  if not i
    i = encode(uuidv4(null, []))
    localforage.setItem(token, i)
  _token = =>
    new Promise((resolve)=>resolve(i))
  i

postMessage = (msg) =>
  for i in await clients.matchAll()
    i.postMessage msg

ACTION = {
  '': ->
    r = {
      TOKEN: await _token()
    }
    if ME == undefined
      ME = await localforage.getItem 'me'
    if ME
      r.ME = ME
    client = await clients.get(@source.id)
    client.postMessage r

  logout:=>
    await localforage.removeItem('me')
    ME = undefined
    postMessage {ME}

  me:(ID, NAME)=>
    ME = {ID, NAME}
    await localforage.setItem('me', ME)
    postMessage {ME}
}

self.addEventListener(
  'message'
  (event) =>
    data = event.data
    if typeof data == 'string'
      ACTION[data].apply event
    else
      for k, v of data
        ACTION[k].apply event, v

)

con = console

VERSION = 1
HOST = location.host
HOST_URL = "https://#{HOST}/"

self.addEventListener(
  "fetch"
  (event) =>
    req = event.request
    method = req.method
    url = new URL(req.url)
    host = url.host

    if ["GET", "OPTIONS"].indexOf(method) < 0 or url.protocol != "https:"
      return

    if host == HOST and url.pathname.indexOf(".") < 0
      req = new Request(HOST_URL, { method: method })

    event.respondWith(
      caches.match(req).then (res)=>
        if res
          cache = res.headers.get("cache-control") or ''
          while 1
            if cache
              if cache == "no-cache"
                break
              sec = /max-age=(\d+)/.exec(cache)
              if sec and (
                (
                  (
                    new Date()/1000 - parseInt(res.headers.get("_"),16)
                  ) - sec[1]
                ) > 0
              )
                break
            return res
        try
          r = await get(req)
        catch e
          if res
            con.error e
            return res
          throw e
        if res and res.ok and (not r.ok)
          return res
        return r
    )
)

#reget = (req, res) =>
#  new Promise (resolve) =>
#    url = new URL(req.url)
#    pathname = url.pathname.slice(1)
#
#    # if (["h.js", "s.js"].indexOf(pathname) + 1) {
#    #   get(req)
#    # }
#    resolve(res)

get = (req) =>
  url = new URL(req.url)

  if url.host != HOST
    config = {
      credentials: "omit"
      mode: "cors"
    }
    try
      res = await fetch(req, config)
    catch e
      delete config.mode
      res = await fetch(req, config)
  else
    res = await fetch(req)

  if res and res.ok
    rc = new Response(res.clone().body, res)
    rc.headers.set "_", parseInt((new Date)/1000).toString(16)
    caches.open( VERSION ).then (cache) =>
      cache.put(req, rc)
  return res


