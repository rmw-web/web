import { onUnmounted} from 'vue'
export default (elem, dict)=>
  for event,func of dict
    elem.addEventListener(event, func)
  unbind = =>
    for event,func of dict
      elem.removeEventListener(event, func)
  onUnmounted unbind
  unbind
