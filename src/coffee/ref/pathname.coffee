import {onUnmounted, ref} from 'vue'
import {$on} from '@/coffee/$'

export default (base="/") =>
  pathname = ref()
  base = base.length
  pushState = =>
    pathname.value = location.pathname.slice(base)
  pushState()
  onUnmounted $on window, {
    pushState
  }
  pathname