#!npx coffee

path = require 'path'
fs = require 'fs-extra'
{template} = require 'lodash'
chalk = require 'chalk'

read = (file)=>
  (await fs.readFile(path.join(__dirname,file),"utf-8")).trim()

do =>
  HOST = require('../../config/host')

  outpath = "/etc/nginx/conf.d/_.#{HOST}.conf"
  console.log chalk.yellowBright("配置文件路径 "+outpath)
  await fs.writeFile(
    outpath
    template(await read('dev.conf')) {HOST}
  )
