<style lang="stylus" scoped>
@import '@/pkg/main/styl/ico/gg/add'
@import './me/me'
@keyframes move
  0%
    transform translateX(0px)
  100%
    transform translateX(-100%)
.scrollbar>div>div>main
  &>footer
    margin-top 0.8rem
  &>header
    padding 2.3rem
    width 100%
    &>footer
      display flex
      margin-top 1.15rem
      color #666
      overflow hidden
      &>i
        background #fff
        z-index 1
        margin-right 1rem
        position relative
        &:after
          content ''
          position absolute
          height 100%
          right -1rem
          width 1rem
          background linear-gradient(to right, #fff, rgba(255, 255, 255, 0))
      &>.marquee
        animation 180s move linear infinite normal
        display flex
        &>a
          white-space nowrap
          color #666
          padding-right 0.5rem
          &:hover
            color #f40
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
      footer
        i 🔥
        .marquee
          a #网络犯罪以年均近40%速度攀升#
          a #白云机场成2020年全球客流量最大机场#
          a #八小时工作制#
          a #拜登重整中美关系#
          a #荷兰实施全国宵禁#
          a #除了当事人大家都很快乐#
    i.logo
    h1
      a 下一代互联网宣言
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

