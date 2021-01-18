import Pop from "@/coffee/Pop"
import {URL as _URL} from '../url.txt'
URL = new Set(_URL.split("\n"))

INDEX = 'index'
HTTP404 = '/_/http/404'


export default (pathname)=>
  if pathname == ""
    return INDEX
  if URL.has pathname
    return pathname
  return HTTP404
  # if pathname.startsWith '-'
  #   pathname = pathname.slice(1)
  #   if pathname.startsWith "auth/"
  #     pathname  = pathname.split("~")
  #     url = pathname[0].slice(5)
  #     if pathname.length > 1 or url == "me"
  #       if url == 'reset'
  #         url = "new"
  #       return "/auth/vue/#{url}"
  #     Pop('auth/vue/login')
  #     return INDEX
  #
  #   if pkg_template.has(pathname)
  #     return pathname
  #
  #   switch pathname
  #     when "join"
  #       return INDEX
  #     else
  #       return HTTP404
  # else if pathname
  #   return 'id'
  # else
  #   return INDEX
