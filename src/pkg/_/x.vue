<style lang="stylus" scoped>
a.X
  font-weight 100
  color #000
  border 1px solid #000
  height 4rem
  width 4rem
  margin auto
  border-radius 2rem
  transform scale(0.5)
  &:before, &:after
    width 2.2rem
    height 1px
    background #000
    content ''
    position absolute
    top 2rem
    left 0.9rem
    transform rotate(45deg)
  &:before
    transform rotate(-45deg)
  &:hover
    color #f40
    border-color #f40
    &:before, &:after
      background #f40
main
  user-select none
  margin auto
  display flex
  flex-flow column
</style>
<template lang="pug">
main
  a.X(href="/")
  slot
</template>
<script lang="coffee">
import $on from '@/coffee/$/on'
import {onUnmounted} from 'vue'
export default {
  setup : =>
    onUnmounted $on document,{
        keyup:(e)=>
          if ['INPUT','TEXTAREA'].indexOf(e.target.tagName)+1
            return
          if e.keyCode == 27
            history.pushState(null,null,'/')
      }
    {}

}
</script>
