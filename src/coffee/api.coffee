import Pop from "@/coffee/Pop"
import API from '@/config/api.txt'
import {route} from "@/coffee/route"
CONTENT_TYPE = "Content-Type"
APPLICATION_JSON = 'application/json'
URL = "//"+API

_ajax = (method) =>
  (url,body)=>
    headers = {}
    if typeof(body) != "string"
      type = APPLICATION_JSON
      body = JSON.stringify(body)
    else
      type = "text/plain"

    headers[CONTENT_TYPE] = type
    # headers['I'] = TOKEN

    r = await fetch(
      URL+url
      {
        method
        headers
        body
      }
    )
    content_type = r.headers.get(CONTENT_TYPE)
    {status} = r
    switch status
      # when 401
      #   await Pop('auth/vue/login')
      #   route('auth/vue/_empty')
      #   await new Promise(=>)
      #   return
      when 404, 500
        alert "出错了!\n错误码: #{status}\n请求网址 : #{url}"
        return
    txt = await r.text()
    if content_type and content_type.startsWith(APPLICATION_JSON)
      if txt
        txt = JSON.parse txt
        if status == 412
          throw txt
      else
        return {}
    return txt

export post = _ajax "POST"
export get = _ajax "GET"
