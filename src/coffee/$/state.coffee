import $on from './on'

export default (f)=>
  $on window, {
    pushState:f
    popstate:f
  }
