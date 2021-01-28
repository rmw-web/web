<style lang="stylus" scoped>
@import './me'
main
  margin-top 2.3rem
</style>

<template lang="pug">
scrollbar(ref="scroll")
  main
    i.logo
    h1 欢迎加入下一代互联网
    h2 去中心化 · 无服务器
    h2 人人平等 · 畅所欲言
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
      button(type="submit") 创建账户
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

