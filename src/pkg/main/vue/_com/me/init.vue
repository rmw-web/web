<style lang="stylus" scoped>
@import './me'
main, form, footer
  margin-top 2.3rem
p
  display flex
  width 60%
  flex-direction row-reverse
  align-items center
  justify-content center
  position relative
  margin-bottom 1.5rem
  &>button
    justify-content center
    background #36c
    color #fff
    border 1px solid #36f
  &>label
    position absolute
    left 0.5rem
input, button
  width 100%
  padding 0.5rem
  display flex
  font-size 1rem
  outline 0
input
  border 1px solid #ccc
  color #000
form, footer
  background url("data:image/svg+xml;utf-8,<svg xmlns='http://www.w3.org/2000/svg' width='100%' height='1px'><line x1='0' y1='0' x2='100%' y2='0' stroke-dasharray='3,3' stroke='rgb(185,185,185)'></line></svg>") 0 0 no-repeat
form, footer
  padding-top 2.3rem
  display flex
  width 100%
  flex-direction column
  align-items center
</style>

<template lang="pug">
scrollbar(ref="scroll")
  main
    i.logo
    h1 欢迎加入下一代互联网
    h2 去中心化 · 无服务器
    h2 人人平等 · 畅所欲言
    form
      h1 创建账户
      p
        input
        label 网名
      p
        input
        label 城市
      p
        input
        label 公司
      p
        input
        label 职衔
      p
        input
        label 发帖语言
      p
        input
        label 阅读语言
      p
        input
        label 头像图标
      p
        button(type="submit") 开始使用
    footer
      a
        h1 加入我们
        h2 有志者 · 事竟成 · 破釜沉舟 · 百二秦关终属楚
</template>


<script lang="coffee">
import Scrollbar from '@/lib/scrollbar'
import {shallowRef, onMounted} from 'vue'

export default {
components:{
  Scrollbar
}
setup:=>
  scroll = shallowRef()
  txt = shallowRef()
  onMounted =>
    # txt.value.focus()
  {
    txt
    scroll
  }
}
</script>

