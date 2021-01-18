<style lang="stylus" scoped>
.scrollbar
  overflow auto
  -ms-overflow-style none
  scrollbar-width none
  position relative
.scrollbar::-webkit-scrollbar
  width 0
.scrollbar>div
  min-height 100%
  display flex
  width 100%
  align-items center
  justify-content center
.scrollbar>aside
  user-select none
  position sticky
  width 1rem
  height 100%
  top 0
  left 100%
  &>i
    position absolute
    display block
    width 40%
    margin-top 2px
    margin-bottom 2px
    border-radius 0.3rem
    margin-left 45%
    transition width 0.3s, margin 0.3s, background 0.3s
    background rgba(0, 0, 0, 0.15)
  &:hover
    background rgba(200, 200, 200, 0.3)
    &>i
      background rgba(0, 0, 0, 0.3)
      width 50%
      margin-left 30%
</style>

<template lang="pug">
.scrollbar(ref="main")
  div(ref="wrap")
    slot
  aside(@click="click" ref="aside")
    i(ref="i")
</template>


<script lang="coffee">
import {shallowRef, onMounted, onUnmounted} from 'vue'
import $on from '@/coffee/$/on'

Scroll = (elem) =>
  runing = 0
  {requestAnimationFrame, cancelAnimationFrame} = window
  (to)=>
    cancelAnimationFrame runing
    duration=300
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

export default {
components:{

}
setup:=>
  main = shallowRef()
  wrap = shallowRef()
  i = shallowRef()
  aside = shallowRef()
  scrollTo = undefined
  onMounted =>
    iv = i.value
    mv = main.value
    wv = wrap.value
    av = aside.value
    scrollTo = Scroll mv
    scroll = =>
      {clientHeight,scrollHeight,scrollTop} = mv
      if scrollHeight <= clientHeight
        av.style.display = "none"
      else
        av.style.display = ""
      height = Math.max(parseInt(clientHeight*clientHeight/scrollHeight)-4,48)
      iv.style.height = height+"px"
      iv.style.top = parseInt(scrollTop/(scrollHeight-clientHeight)*(clientHeight-4-height))+"px"
      return
    ro = new ResizeObserver =>
      scroll()
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
    return
  {
    main
    i
    aside
    wrap
    #TODO 拖拽 mousemove
    #TODO 自动隐藏
    click:(e)=>
      mv = main.value
      {clientHeight,scrollHeight} = mv
      scrollTo parseInt(e.offsetY/clientHeight * (scrollHeight-clientHeight))
      return

  }
}
</script>

