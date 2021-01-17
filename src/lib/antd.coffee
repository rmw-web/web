#!/usr/bin/env coffee
import {thisdir} from '@rmw/thisfile'
import fs from 'fs'
import {join, resolve} from 'path'
import {basename} from 'path'
import startCase from 'lodash/startCase'
import {mkdir} from 'fs/promises'

lsdir = (dir) ->
  for i from fs.readdirSync(dir)
    p = join(dir,i)
    if fs.statSync(p).isDirectory()
      style = join p,"style"
      if fs.existsSync(style)
        yield p

do =>
  pwd = thisdir(`import.meta`)
  out = join pwd,"antd"
  dir = resolve pwd,"../../node_modules/ant-design-vue/lib"
  dir_styl = join out,"styl"
  await mkdir(
    dir_styl
    { recursive: true }
  )

  for await i from lsdir(dir)
    name = basename i
    cls =  startCase(name).replace(/\s/g,"")
    # 必须用 import() 这样来异步，不然会有覆盖的问题
    txt = """
import {#{cls}} from 'ant-design-vue'
import 'ant-design-vue/lib/#{name}/style'
import('./styl/#{name}')
export default #{cls}
"""
    styl = join(dir_styl, name+".styl")
    if not fs.existsSync styl
      fs.writeFileSync styl,""

    filepath = join out, name+".coffee"

    fs.writeFileSync(
      filepath
      txt
    )
  process.exit()
