#!npx coffee

require('../../webpack/urlbase64')
crypto = require 'crypto'
path = require 'path'
terser = require 'terser'
pug = require 'pug'
fs = require 'fs-extra'

ROOT = path.resolve path.join(__dirname,"../..")

filepath = (file)=>
  path.resolve(ROOT, file)

fileread = (file)=>
  fs.readFileSync(filepath(file), "utf-8").trim()

fileset = (file, txt)=>
  fs.outputFile(filepath(file), txt)


html2txt = (cdn, pug)=>
  css = []
  js = []
  _url = (i)=>i.split("=")[1].split(' ')[0].slice(cdn.length)
  # prefetch = {css:[], js:[]}
  for i in pug.split("<")
    i = i.replace('>',' ')
    if i.startsWith('link ')
      css.push _url(i).slice(0,-4)
    else if i.startsWith('script ')
      url = i.split("=")[1].split(' ')[0]
      js.push _url(i).slice(0,-3)

  [
    css.join('/')
    js.join('/')
    # prefetch.css.join(' ')
    # prefetch.js.join(' ')
  ]

do =>
  distDir = 'dist/'
  indexHtml = distDir+"index.html"

  cdn = fileread "src/config/cdn.txt"

  txt = html2txt(
    cdn
    fileread indexHtml
  )
  # console.log txt

  jsDir = ROOT+"/src/sh/_dist/"
#   h = fileread(js-dir+"h.js").replace(
#     '$tongji'
#     fileread 'config/tongji.txt'
#   ).replace('$li', txt.join(';'))
  h = fileread(jsDir+"index.js")
  h = terser.minify(h)

  #.replace('$li', txt.join(';'))

  if not h.code
    console.error h
    return

  h = h.code
  js = crypto.createHash('sha512').update(h).digest('urlbase64').slice(0,7)+'.js'
  await fileset distDir+js, h
  await fileset(
    indexHtml.slice(0,-1)
    pug.render(
      fileread jsDir+"index.pug"
      {
        cdn
        js:js+"#"+txt.join("#")
      }
    )
  )





