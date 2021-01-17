import HOST from '@/config/host'

con = window.console
if con
    style = 'margin:.5rem 0;font-size:1rem;color:#'
    con.log(
        "%c\n是看代码实现，还是发现了问题？\n%c加入我们，一起创作吧！\n%c联系邮箱 dev@#{HOST}"
        style+'000'
        style+'f00'
        style+'00f'
    )

body = document.body
if window.devicePixelRatio > 1
  body.classList.add('retina')


# if window.getSelection and document.createRange
#     seletor = {
#         save : (containerEl) ->
#           doc = containerEl.ownerDocument
#           win = doc.defaultView
#           range = win.getSelection().getRangeAt(0)
#           preSelectionRange = range.cloneRange()
#           preSelectionRange.selectNodeContents containerEl
#           preSelectionRange.setEnd range.startContainer, range.startOffset
#           start = preSelectionRange.toString().length
#           {
#             start: start
#             end: start + range.toString().length
#           }
#
#         restore : (containerEl, savedSel) ->
#             doc = containerEl.ownerDocument
#             win = doc.defaultView
#             charIndex = 0
#             range = doc.createRange()
#             range.setStart containerEl, 0
#             range.collapse true
#             nodeStack = [ containerEl ]
#             node = undefined
#             foundStart = false
#             stop = false
#             while !stop and (node = nodeStack.pop())
#               if node.nodeType == 3
#                 nextCharIndex = charIndex + node.length
#                 if !foundStart and savedSel.start >= charIndex and savedSel.start <= nextCharIndex
#                   range.setStart node, savedSel.start - charIndex
#                   foundStart = true
#                 if foundStart and savedSel.end >= charIndex and savedSel.end <= nextCharIndex
#                   range.setEnd node, savedSel.end - charIndex
#                   stop = true
#                 charIndex = nextCharIndex
#               else
#                 i = node.childNodes.length
#                 while i--
#                   nodeStack.push node.childNodes[i]
#             sel = win.getSelection()
#             sel.removeAllRanges()
#             sel.addRange range
#     }
#
# else if document.selection
#     selector = {
#       save : (containerEl) ->
#         doc = containerEl.ownerDocument
#         win = doc.defaultView or doc.parentWindow
#         selectedTextRange = doc.selection.createRange()
#         preSelectionTextRange = doc.body.createTextRange()
#         preSelectionTextRange.moveToElementText containerEl
#         preSelectionTextRange.setEndPoint 'EndToStart', selectedTextRange
#         start = preSelectionTextRange.text.length
#         {
#           start: start
#           end: start + selectedTextRange.text.length
#         }
#
#       restore : (containerEl, savedSel) ->
#         doc = containerEl.ownerDocument
#         win = doc.defaultView or doc.parentWindow
#         textRange = doc.body.createTextRange()
#         textRange.moveToElementText containerEl
#         textRange.collapse true
#         textRange.moveEnd 'character', savedSel.end
#         textRange.moveStart 'character', savedSel.start
#         textRange.select()
#     }

import {escape} from 'lodash'
import txt2html from './txt2html'

select = window.getSelection
if select
  body.addEventListener 'copy', (e)->
      target = e.target
      if ['TEXTAREA','INPUT'].indexOf(target.tagName) >= 0
          return

      s = select().toString().trim()
      if s and s.length >= 50
          title = document.title
          href = location.href

          tip = "来源 : "
          _link = """<a href="#{escape href}" target="_blank">"""

          link = (txt)->
            _link+escape(txt)+"</a>"

          html = "<div>"+txt2html(s)+"""<br><p>#{tip} #{link(title)}</p><p>链接 : #{link(href)}</p></div>"""

          c = e.clipboardData

          p = 'text/plain'
          txt = s+"\n\n#{tip}[#{title}](#{href})"
          c.setData(p, txt)

          if c.getData(p)
              c.setData('text/html', html)
              e.preventDefault()
          return

