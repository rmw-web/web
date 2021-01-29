<style lang="stylus" scoped>
@import './me'
main, footer
  margin-top 2.3rem
main>h2
  color #CB3333
  font-size 1.1rem
  letter-spacing 0.1rem
  font-weight 100
  margin -1rem 0 0
  user-select none
  &>p
    margin 0 0 0.5rem
form
  margin 1.6rem 0 0
  padding 0 2.3rem
  &>h1
    margin-bottom 2rem
  p
    display flex
    width 100%
    flex-direction row-reverse
    align-items center
    justify-content center
    position relative
    margin 0 0 1.5rem
    box-sizing border-box
    &>button
      justify-content center
      background #36c
      color #fff
      border 1px solid #36f
    &>label
      position absolute
      left 0.65rem
      padding 0 0.5rem
      transition all 0.2s
      color #999
    &>input:not(:placeholder-shown) + label
      font-size 0.5rem
      background #fff
      top 3.1rem
    &>input:hover
      border-color #333
    &>input:focus
      border-color #06f
      box-shadow 0 0 0 2px rgba(24, 14, 255, 20%)
      &+label
        color #666
      &:not(:placeholder-shown)+label
        color #06f
input, button
  width 100%
  padding 1rem
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
    h2
      p 去中心化 · 无服务器
      p 人人平等 · 畅所欲言
    form(ref="form")
      h1 欢迎加入下一代互联网
      p
        input(placeholder=" ")
        label 网名
      p
        a-select
        label 国家
      p
        input(placeholder=" ")
        label 城市
      p
        input(placeholder=" ")
        label 公司
      p
        input(placeholder=" ")
        label 职衔
      p
        a-select
        label 第一语言
      p
        a-select
        label 第二语言（可多选）
      p
        input(placeholder=" ")
        label 头像图标
      p
        button(type="submit") 创建账户
    footer
      a
        h1 加入我们
        h2 有志者 · 事竟成 · 破釜沉舟 · 百二秦关终属楚
</template>


<script lang="coffee">
import Scrollbar from '@/lib/scrollbar'
import {shallowRef, onMounted} from 'vue'
import ASelect from '@/lib/antd/select'

export default {
components:{
  Scrollbar
  ASelect
}
setup:=>
  scroll = shallowRef()
  form = shallowRef()
  onMounted =>
    form.value.getElementsByTagName("input")[0].focus()
    return
  {
    form
    scroll
  }
}
</script>

