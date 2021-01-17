#!/usr/bin/env coffee

path = require 'path'
inquirer = require 'inquirer'
axios = require 'axios'
fs = require 'fs-extra'

API_PARAM = {
  baseURL: "https://api.upyun.com/"
}
API = axios.create(API_PARAM)

do =>
  HOST = require(path.join(__dirname, '../../config/host')
  token_file = path.join(
    require('os').homedir(),'.config/upyun/token',HOST
  )
  if not await fs.exists token_file
    console.log "生成又拍云访问令牌"
    username = process.env.UPYUN_USERNAME
    password = process.env.UPYUN_PASSWORD
    prompt = []
    if not username
      prompt.push {
        type:'input'
        name:'username'
        message:"请输入又拍云用户名: "
      }
    if not password
      prompt.push {
        type:'password'
        name:'password'
        message:"请输入又拍云登录密码: "
      }
    if prompt.length
      r = await inquirer.prompt prompt
      username = username or r.username
      password = password or r.password

    token_name = HOST+"-"+parseInt((new Date)/1000).toString(16)
    {data} = await API.post 'oauth/tokens', {
      code  : (parseInt(Math.random()*10000000)+""+parseInt(new Date()-0))
      scope : 'global'
      name  : token_name
      username
      password
    }
    {access_token} = data
    if access_token
      await fs.outputFile token_file, data.access_token
      API_PARAM.headers = {
        Authorization : "Bearer #{access_token}"
      }
      API = axios.create API_PARAM
      for i in (await API.get("oauth/tokens")).data
        if i.name == token_name
           continue
        else if i.name.startsWith(HOST+"-")
          # 删除不用的token
          console.log "删除", i
          await API.delete("oauth/tokens", {
            params:
              name:i.name
          })
    else
      console.log data
      process.exit()
  console.log 'token 文件路径', token_file
