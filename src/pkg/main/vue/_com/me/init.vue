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
form
  margin 1.6rem 0 0
  padding 0 2.3rem
  &>h1
    margin-bottom 2rem
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
    a-form(:model="form" :rules="rules" @finishFailed="finishFailed")
      h1 欢迎加入下一代互联网
      a-form-item(:class="{s:form.lang}")
        a-select(v-model:value="form.lang" :getPopupContainer="body" :showSearch="true")
          a-select-option(v-for="val in C.LANG" :value="val") {{val}}
        label 语言
      a-form-item(name="name")
        input(placeholder=" " v-model="form.name" autocomplete="off")
        label 姓名 或 昵称
      a-form-item(name="org")
        input(placeholder=" " v-model="form.org" autocomplete="off")
        label 公司 或 组织
      a-form-item(name="title")
        input(placeholder=" " v-model="form.title" autocomplete="off")
        label 职位 或 头衔
      a-form-item(:class="{s:form.sex}" name="sex")
        a-select(v-model:value="form.sex" :getPopupContainer="body")
          a-select-option(v-for="val in C.SEX" :value="val") {{val}}
        label 性别 或 物种
      a-form-item(:class="{s:form.zone}" name="zone")
        a-select(v-model:value="form.zone" :getPopupContainer="body" :showSearch="true")
          a-select-option(v-for="val in C.ZONE" :value="val") {{val}}
        label 国家 或 自治区
      a-form-item(name="city")
        input(placeholder=" " v-model="form.city" autocomplete="off")
        label 城市 或 城区
      a-form-item
        input(placeholder=" ")
        label 头像
      a-form-item
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
import AForm from '@/lib/antd/form'
import LANG from '@/const/lang'
import ZONE from '@/const/zone'

export default {
components:{
  Scrollbar
  ASelect
  AForm
  AFormItem:AForm.Item
  ASelectOption:ASelect.Option
}
setup:=>
  scroll = shallowRef()
  main = shallowRef()
  {language} = navigator
  language_prefix = language.split("-",1)[0]
  for [name, en] from LANG
    if [language,language_prefix].indexOf(en)+1
      lang = name
      break
  form = ref {
    lang
    zone:""
    name:""
    org:""
    sex:""
    title:""
    zone:""
    city:""
  }
  onMounted =>
    # form.value.getElementsByTagName("input")[1].focus()
    return

  requireSelect = [
    { required: true, message: '请选择', trigger: 'blur' }
  ]
  requireInput = [
    { required: true, message: '请输入', trigger: 'blur' }
  ]
  {
    form
    scroll
    rules:{
      city:requireInput
      name:requireInput
      org:requireInput
      sex:requireSelect
      title:requireInput
      zone:requireSelect
    }
    body:=>
      scroll.value.main
    C:{
      LANG:(i[0] for i from LANG)
      ZONE:(i[0] for i from ZONE)
      SEX:"男/女/机器人".split('/')
    }
    finishFailed:(o)=>
      m = scroll.value.main
      err = m.getElementsByClassName("has-error")[0]
      m.scrollTop = err.parentNode.parentNode.offsetTop - 16
      err.getElementsByTagName("input")[0].focus()
      return
  }
}
</script>

