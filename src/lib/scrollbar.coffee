import Scrollbar from 'smooth-scrollbar'
import {onUnmounted} from 'vue'
#TODO
export default (elem)=>
  s = Scrollbar.init elem
  setTimeout(
    =>
      s = Scrollbar.init elem
    1000
  )
  onUnmounted =>
    s.destroy()
  s

