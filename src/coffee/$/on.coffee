import $on from './_on'
import { onUnmounted} from 'vue'
export default (elem, dict)=>
  unbind = $on elem, dict
  onUnmounted unbind
  unbind
