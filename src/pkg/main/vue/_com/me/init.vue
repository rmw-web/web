<style lang="stylus" scoped>
@import '~@/styl/reset/form.styl'
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
form
  margin 1.6rem 0 0
  padding 0 2.3rem
  &>h1
    margin-bottom 2rem
  p
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
    h2 去中心化 · 无服务器 · 人人平等 · 畅所欲言
    form(ref="form" @submit.prevent="submit")
      h1 欢迎加入下一代互联网
      p(:class="{s:data.lang}")
        a-select(v-model:value="data.lang" :getPopupContainer="body" :showSearch="true")
          a-select-option(v-for="val in C.LANG" :value="val") {{val}}
        label 语言
      p
        input(placeholder=" ")
        label 姓名 或 昵称
      p
        input(placeholder=" ")
        label 公司 或 组织
      p
        input(placeholder=" ")
        label 职位 或 头衔
      p(:class="{s:data.sex}")
        a-select(v-model:value="data.sex" :getPopupContainer="body")
          a-select-option(v-for="val in C.SEX" :value="val") {{val}}
        label 性别 或 物种
      p(:class="{s:data.zone}")
        a-select(v-model:value="data.zone" :getPopupContainer="body" :showSearch="true")
          a-select-option(v-for="val in C.ZONE" :value="val") {{val}}
        label 国家 或 自治区
      p
        input(placeholder=" ")
        label 城市 或 城区
      p
        input(placeholder=" ")
        label 头像
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
import LANG from '@/const/lang'
import ZONE from '@/const/zone'

export default {
components:{
  Scrollbar
  ASelect
  ASelectOption:ASelect.Option
}
setup:=>
  scroll = shallowRef()
  form = shallowRef()

  {language} = navigator
  language_prefix = language.split("-",1)[0]
  for [en,name] from LANG
    if [language,language_prefix].indexOf(en)+1
      lang = name
      break
  data = ref {
    lang
    zone:""
    sex:""
  }
  onMounted =>
    form.value.getElementsByTagName("input")[1].focus()
    return
  {
    form
    scroll
    submit:=>
      console.log data.value
      return
    body:=>
      form.value
    C:{
      LANG:(i[0] for i from LANG)
      ZONE:(i[0] for i from ZONE)
      SEX:"男/女/机器人".split('/')
    }
    data
  }
}
</script>

