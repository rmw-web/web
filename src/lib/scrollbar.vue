<style lang="stylus">
.scrollbar
  overflow auto
  -ms-overflow-style none
  scrollbar-width none
  display flex
  flex-direction row-reverse
  position relative
.scrollbar::-webkit-scrollbar
  width 0
.scrollbar>div
  margin auto
.scrollbar>div>div
  min-height 100%
  width 100%
  display flex
  flex-direction column
  align-items center
  justify-content center
.scrollbar>aside
  user-select none
  position sticky
  height 100%
  top 0
  left 100%
  width 1.05rem
  &, &>i
    transition width 0.3s, opacity 1s, top 0.5s, background 0.3s, box-shadow 1s
  &>i
    position absolute
    transition height 0.3s
    display block
    width 0.45rem
    right 0.1rem
    margin 2px 0
    border-radius 0.3rem
    background rgba(0, 0, 0, 0.2)
.scrollbar > div
  width 100%
.scrollbar > aside+div
  margin-right -1.05rem
html.scroll
  cursor grab
  &>body
    pointer-events none
.scrollbar>aside:hover, aside.scroll
  background rgba(125, 125, 125, 0.15)
  opacity 1 !important
  box-shadow inset 0.2rem 0 0.2rem -0.2rem rgba(0, 0, 0, 0.3), inset -0.2rem 0 0.2rem -0.2rem rgba(0, 0, 0, 0.3)
  &>i
    background rgba(0, 0, 0, 0.3)
    width 0.6rem
    right 0.225rem
</style>

<template lang="pug">
.scrollbar(ref="main")
  aside(@click="click" ref="aside" v-if="turn")
    i(ref="si" @mousedown="down")
  div
    div(ref="wrap")
      slot
</template>


<script lang="coffee">
import {nextTick, ref, shallowRef, onMounted, onUnmounted} from 'vue'
import $on from '@/coffee/$/on'

Scroll = (elem) =>
  runing = 0
  {requestAnimationFrame, cancelAnimationFrame} = window
  (to, duration=300)=>
    cancelAnimationFrame runing
    scrollCount = 0
    cosParameter = (elem.scrollTop - to) / 2
    toCos = to+cosParameter
    oldTimestamp = 0
    step = (newTimestamp) ->
      if oldTimestamp
        # if duration is 0 scrollCount will be Infinity
        scrollCount += Math.PI * (newTimestamp - oldTimestamp) / duration
        if scrollCount >= Math.PI
          elem.scrollTop = to
          return
        elem.scrollTop = toCos + cosParameter * Math.cos(scrollCount)
      oldTimestamp = newTimestamp
      runing = requestAnimationFrame step
      return

    if elem.scrollTop == to
      return
    runing = requestAnimationFrame step
    return

SCROLL_CLS = "scroll"
HTML = document.documentElement
export default {
components:{

}
setup:=>
  main = shallowRef()
  wrap = shallowRef()
  si = shallowRef()
  aside = shallowRef()
  scrollTo = undefined
  turn = ref 0

  _mouseunbind = undefined
  mouseunbind = =>
    for i from [HTML, aside.value]
      i?.classList.remove(SCROLL_CLS)
    _mouseunbind?()
    _mouseunbind = undefined

  timer = undefined

  onMounted =>
    mv = main.value
    wv = wrap.value
    scrollTo = Scroll mv
    scroll = =>
      if not turn.value
        return
      {clientHeight,scrollHeight,scrollTop} = mv
      height = Math.max(parseInt(clientHeight*clientHeight/scrollHeight)-4,48)
      iv = si.value
      av = aside.value
      av.style.opacity = 1
      Object.assign(
        iv.style
        {
          height : height+"px"
          top : parseInt(scrollTop/(scrollHeight-clientHeight)*(clientHeight-4-height))+"px"
        }
      )
      clearTimeout timer
      timer = setTimeout(
        =>
          av.style.opacity = 0
        1000
      )
      return
    ro = new ResizeObserver =>
      {clientHeight,scrollHeight} = mv
      if scrollHeight <= clientHeight
        turn.value = 0
      else
        turn.value = 1
      nextTick scroll
    ro.observe wv
    unbind = $on(
      mv
      {
        scroll
      }
    )
    onUnmounted =>
      unbind()
      ro.disconnect()
      mouseunbind()
    return

  {
    turn
    main
    si
    aside
    wrap
    click:(e)=>
      if _mouseunbind
        return
      mv = main.value
      {clientHeight,scrollHeight} = mv
      scrollTo parseInt(e.offsetY/clientHeight * (scrollHeight-clientHeight))
      return
    down:(e)=>
      _mouseunbind?()
      for i from [HTML, aside.value]
        i?.classList.add(SCROLL_CLS)
      mv = main.value
      sv = si.value
      _diff = 0
      Y = e.offsetY
      _mouseunbind = $on document,{
        mouseup:mouseunbind
        mousemove:({offsetY})=>
          {scrollTop,clientHeight,scrollHeight} = mv
          diff = offsetY - Y
          if _diff * diff < 0 or diff == 0 # chrome 经常跳，防抖
            _diff = diff
            return

          ivh = sv.clientHeight + 4
          max = scrollHeight - clientHeight
          st = (offsetY-mv.offsetTop-ivh/2)/(clientHeight-ivh) * max
          if st < 0
            st = 0
          else if st > max
            st = max
          mv.scrollTop = st
          Y = offsetY

          return

      }
  }
}
</script>

