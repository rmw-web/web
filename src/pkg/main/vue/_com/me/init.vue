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
    &>
      input, button, .ant-select
        width 100%
        display flex
        font-size 1rem
        outline 0
      .ant-select > ::v-deep(.ant-select-selector)
        padding 0.84375rem 1rem
        height auto
    &>button
      justify-content center
      background #3889e0
      color #fff
      border 1px solid #3889e0
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
      p(:class="{s:data.lang}")
        a-select(v-model:value="data.lang" :getPopupContainer="body" showSearch="true")
          a-select-option(v-for="[code,val] in opt.lang" :value="val") {{val}}
        label 语言
      p(:class="{s:data.zone}")
        a-select(v-model:value="data.zone" :getPopupContainer="body" showSearch="true")
          a-select-option(v-for="[code,val] in opt.zone" :value="val") {{val}}
        label 国家 或 地区
      p
        input(placeholder=" ")
        label 城市
      p
        input(placeholder=" ")
        label 公司
      p
        input(placeholder=" ")
        label 性别
      p
        input(placeholder=" ")
        label 职衔
      p
        input(placeholder=" ")
        label 网名
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
import {ref, shallowRef, onMounted} from 'vue'
import ASelect from '@/lib/antd/select'
import lang from '@/const/lang'
import zone from '@/const/zone'

export default {
components:{
  Scrollbar
  ASelect
  ASelectOption:ASelect.Option
}
setup:=>
  scroll = shallowRef()
  form = shallowRef()
  data = ref(
    lang:""
    zone:""
  )
  onMounted =>
    form.value.getElementsByTagName("input")[0].focus()
    return
  {
    form
    scroll
    body:=>
      form.value
    opt:{
      lang
      zone
    }
    data
    lang:(val)=>
      console.log "!!!",val,data.value
      return
  }
}
</script>

