<style lang="stylus" scoped>
main
  overflow auto
  -ms-overflow-style none
  scrollbar-width none
  position relative
main::-webkit-scrollbar
  width 0
aside
  position sticky
  width 1rem
  height 100%
  top 0
  left 100%
  &>i
    height 200px
    display block
    width 40%
    border-radius 0.3rem
    margin-left 45%
    transition all 0.3s
    background rgba(0, 0, 0, 0.15)
  &:hover
    background rgba(200, 200, 200, 0.3)
    &>i
      background rgba(0, 0, 0, 0.3)
      width 60%
      margin-left 20%
</style>

<template lang="pug">
main(ref="main")
  slot
  aside
    i(ref="i")
</template>


<script lang="coffee">
import {shallowRef, onMounted, onUnmounted} from 'vue'
import $on from '@/coffee/$/on'

export default {
components:{

}
setup:=>
  main = shallowRef()
  i = shallowRef()
  onMounted =>
    mv = main.value
    unbind = $on(
      mv
      scroll:=>
        console.log "top", mv.scrollTop, "height", mv.clientHeight

    )
    onUnmounted =>
      unbind()
  {
    main
    i
  }
}
</script>

