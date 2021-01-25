<style lang="stylus" scoped>
@import '@/pkg/main/styl/ico/gg/add'
.scrollbar>div>div>main
  display flex
  width 100%
  flex-direction column
  align-items center
  &>footer
    font-family h
    margin 0.8rem 2.3rem 1rem
    display flex
    text-align center
    flex-direction column
  h1 > a, &>footer>a
    user-select none
    color #000
    margin-bottom 2.3rem
    &:hover
      color #f40
  &>footer>a:hover
    &>h1, &>h2
      color #f40
  &>i.logo
    height 0
    margin 0 2.3rem 2.3rem
    width 100%
    padding-bottom 38%
    background url('~@/file/img/svg/logo.svg') 50% 50% / cover no-repeat
  &>header
    padding 2.3rem
    width 100%
    &>main
      position relative
      display flex
      &>textarea
        width 100%
        outline 0
        border 1px solid #ccc
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
    header
      main
        a-textarea(required placeholder="写点什么 ？人民网络 ，畅所欲言 ···" :autoSize="true" ref="txt")
        a.I.send(title="快捷键 Ctrl+Enter")
    i.logo
    h1
      a 下一代互联网宣言
    h1
      a 使用指南
    h1
      a 技术架构
    footer
      a
        h1 加入我们
        h2 有志者 · 事竟成 · 破釜沉舟 · 百二秦关终属楚
</template>


<script lang="coffee">
import AInput from '@/lib/antd/input'
import Scrollbar from '@/lib/scrollbar'
import {shallowRef, onMounted} from 'vue'

export default {
components:{
  ATextarea:AInput.TextArea
  Scrollbar
}
setup:=>
  scroll = shallowRef()
  txt = shallowRef()
  onMounted =>
    txt.value.focus()
  {
    txt
    scroll
  }
}
</script>

