import WS from './ws/dev'
import {get,post} from '@/coffee/api'
global = {
  WS
  API:{
    get
    post
  }
}

Object.assign(
  window
  global
)
setTimeout(
  =>
    console.log(
      "%c调试可用的全局变量 : #{Object.keys(global).join(' ')}"
      'font-size:1rem;color:#0f0;background:#000;padding:1rem;font-weight:bold'
    )
  1000
)
