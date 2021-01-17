import imsize from 'markdown-it-imsize'
import footnote from 'markdown-it-footnote-6du'
import blockImagePlugin from 'markdown-it-block-image'
import markdownItTocAndAnchor from 'markdown-it-toc-and-anchor'
import markdown from 'markdown-it'

md = markdown({
  breaks : true
}).use(
  imsize
).use(
  footnote
).use(
   blockImagePlugin
  {
    outputContainer: 'p',
    containerClassName: "img"
  }
)
# ).use(
#   markdownItTocAndAnchor
#   * tocClassName : \mdToc
#     anchorLinkSpace: false
#     anchorClassName: \mdH
#     anchorLinkSymbol: \»
#     anchorLinkPrefix: \-
# )

# _PATH = undefined

render_image = md.renderer.rules.image

md.renderer.rules.image = (tokens, idx, options, env, self) ->
  token = tokens[idx]
  # src = "src"
  # s = token.attrGet(src)
  # s2
  # if s.charAt(0) == "/" and s.charAt(1) != "/"
  #   s2 = s
  # else if s.indexOf("://") < 0
  #   s2 = _PATH + "/md/" + s
  # if s2
  #   token.attrSet(src, _IMG+s2)
  token.attrSet('onload', '_mdImg(this)')
  token.attrSet("crossOrigin",'')
  return "<span class=img><i>#{render_image(tokens, idx, options, env, self)}</i></span>"

window._mdImg = (img)=>
  width = 128
  height = Math.round(width*img.height/img.width)

  canvas = document.createElement('canvas')
  canvas.width = width
  canvas.height = height

  ctx = canvas.getContext('2d')
  ctx.drawImage(img, 0, 0,img.naturalWidth, img.naturalHeight,0,0,width,height)
  {data} = ctx.getImageData(0, 0, width, height)
  count = 0
  for row in [0, height-1]
    col = 0
    while col < width
      line = (width*row+col)*4
      ++col
      t = data.slice(line,line+4)
      if t[3] == 0 or (t[0]+t[1]+t[2])==765
        count+=1

  for col in [0,width-1]
    row = 1
    while row < height-1
      line = (width*row+col)*4
      ++row
      t = data.slice(line,line+4)
      if t[3] == 0 or (t[0]+t[1]+t[2])==765
        count+=1
  if count/(width+height-2) < 0.4
    img.parentNode.className="s"

export default (txt)=>
  # _IMG = img
  # path = path or location.pathname
  # path = path.slice(0,path.lastIndexOf("/"))
  # _PATH = path
  md.render txt

