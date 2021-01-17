#!/usr/bin/env coffee

path = require 'path'
axios = require 'axios'
fs = require 'fs-extra'
chalk = require 'chalk'

API_PARAM = {
  baseURL: "https://api.upyun.com/"
}
API = axios.create(API_PARAM)

do =>
  HOST = require path.join(__dirname, '../../config/host')
  token_file = path.join(
    require('os').homedir(),'.config/upyun/token',HOST
  )
  if not await fs.exists token_file
    console.log chalk.gray(
      """没有又拍云令牌，不刷新CDN缓存
如有需要，请运行
#{chalk.blue('$')} #{chalk.greenBright("npx coffee "+path.join(__dirname,"./upyun.token.coffee"))}
生成令牌"""
    )
    process.exit()
  token = await fs.readFile token_file, "utf-8"
  API_PARAM.headers = {
    Authorization : "Bearer #{token}"
  }
  API = axios.create API_PARAM
  cdn_name = "renwu-cool"
  update = (host, url)=>
    url = '/' + url
    {data} = await API.post "purge", {
      urls:"https://#{host}#{url}"
    }
    for i in data.result
      console.log i.url, i.status

  await Promise.all [
    update HOST, "sw.js"
    update HOST, ""
  ]


#  删除不用的token
#  for i in (await API.get("oauth/tokens")).data
#    if i.name == HOST
#      continue
#    await API.delete("oauth/tokens", {
#      params:
#        name:i.name
#    })
