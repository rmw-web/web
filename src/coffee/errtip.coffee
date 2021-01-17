import {$on} from '@/coffee/$'
import {isFunction} from 'lodash'

tip = (i, text)=>
  while 1
    p = i.parentNode
    if p.tagName == 'LI' or not p
      break
  p.querySelector('mark')?.remove()
  mark = document.createElement 'mark'
  mark.innerHTML = text
  p.appendChild mark
  unmount = $on(
    i
    {
      keyup : (e)=>
        if not ([9,37,13,39].indexOf(e.keyCode) + 1)
          p.querySelector('mark').className = 'op'
      change : =>
        p.querySelector('mark')?.remove()
        unmount()
    }
  )
  unmount

export default (func, i18n)=>
  li = []
  timeout = undefined
  (e)->
    elem = e.target
    ing = 'ing'
    if timeout
      return
    for i in li
      i()
    li = []
    for i in elem.querySelectorAll('mark')
      i.remove()
    timeout = setTimeout(
      =>
        elem.className = ing
        timeout = undefined
      200
    )
    try
      await func.apply @,arguments
    catch err
      focus = undefined
      for i in elem.querySelectorAll('[name]')
        {name} = i
        text = err[name]
        if text
          if not focus
            if ['INPUT','TEXTAREA'].indexOf(i.tagName)+1
              i.focus()
              focus = 1
          if isFunction i18n
            i18n = i18n.apply @, arguments
          li.push tip(i, i18n[name][text-1])
    finally
      clearTimeout timeout
      timeout = undefined
      elem.className = ''


