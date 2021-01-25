<style lang="stylus" scoped>
@import '@/pkg/main/styl/ico/gg/add'
.scrollbar>div>div>main
  display flex
  width 100%
  flex-direction column
  &>i.logo
    height 0
    margin 2.3rem 2.3rem 0
    width 100%
    padding-bottom 38%
    background url('//raw.githubusercontent.com/rmw-link/logo/master/rmw.svg') 50% 50% / cover no-repeat
  &>header
    position relative
    display flex
    margin 2.3rem
    &>textarea
      width 100%
      outline 0
      border 1px solid #999
      resize none
      height 3.4rem
      font-size 1rem
      line-height 1.8
      padding 1rem 1.8rem 0.8rem 1rem
      color #000
      /*
      &:invalid+.send
        display none
      */
    sendWidth = 1.4rem
    &>.send
      position absolute
      bottom 1.42rem
      width sendWidth
      height sendWidth
      right 0.6rem
      z-index 1
      &:after
        color #999
        font-size sendWidth
        content '\e601'
        font-family I
      &:hover
        &:after
          color #f40
          content '\e605'
</style>

<template lang="pug">
scrollbar(ref="scroll")
  main
    i.logo
    header
      a-textarea(required placeholder="写点什么 ？人民网络 ，畅所欲言 ···" :autoSize="true")
      a.I.send(title="快捷键 Ctrl+Enter")
</template>


<script lang="coffee">
import AInput from '@/lib/antd/input'
import Scrollbar from '@/lib/scrollbar'
import {shallowRef} from 'vue'

export default {
components:{
  ATextarea:AInput.TextArea
  Scrollbar
}
setup:=>
  scroll = shallowRef()
  {
    scroll
  }
}
</script>

