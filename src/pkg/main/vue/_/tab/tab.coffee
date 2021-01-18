import {ref, onBeforeMount} from 'vue'
import goto from '@/coffee/goto'

class Tab
  constructor:->
    @ref = ref []
    @li = @ref.value
    @exist = new Set()

  open: (title)->
    onBeforeMount =>
      {exist,li} = @
      document.title = title
      path = location.pathname[1..]
      if not exist.has path
        exist.add path
        li.push [title, path]
    return

  x:(pos)->
    {exist,li} = @
    url = li[pos][1]
    exist.delete url
    li.splice(pos,1)
    path = location.pathname[1..]
    if path == url
      len = li.length
      if len--
        if len <= pos
          pos = len
        console.log "goto #{pos}",li
        goto li[pos][1]
      else
        console.log "goto /"
        goto '/'
    return


export default tab = new Tab()
export tab = tab.open.bind(tab)
