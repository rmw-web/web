import {ref} from 'vue'
import $on from '@/coffee/$/on'

export default (base="/") =>
  pathname = ref()
  base = base.length
  pushState = =>
    pathname.value = location.pathname.slice(base)
  pushState()
  $on window, {
    pushState
  }
  pathname
