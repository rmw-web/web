
import {onMounted,ref} from 'vue'

export default (self)->
  focus = ->
    setTimeout =>
      li = @form.querySelectorAll 'input'
      t = []
      for i in li
        if i.disabled
          continue
        if not i.value
          i.focus()
          return
        t.push i
      t[0]?.focus()

  onMounted ->
    @focus()

  {
    focus
    form : ref(null)
  }


