<style lang="stylus" scoped></style>

<template lang="pug">
.page
  main
    h1 配置
</template>


<script lang="coffee">
import {add} from "@/ws/task"
import {onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'
import AButton from '@/lib/antd/button'
import {tab} from './_/tab/tab'
export default {
components:{
  AButton
}
setup:=>
  tab "系统配置"
  return
}
</script>

