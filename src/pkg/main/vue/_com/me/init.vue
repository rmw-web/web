<style lang="stylus" scoped>
@import './me'
</style>

<template lang="pug">
scrollbar(ref="scroll")
  main
    form
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
        label 头衔
      p
        input
        label 发帖语言
      p
        input
        label 阅读语言
      button(type="submit") 创建用户
    i.logo
    h1
      a 下一代互联网宣言
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

