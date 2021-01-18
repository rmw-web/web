<style lang="stylus" scoped></style>

<template lang="pug">
.page
  main
    h1 配置
</template>


<script lang="coffee">
import {add} from "@/ws/task"
import DB from '@/db/rxdb'
import {onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'
import AButton from '@/lib/antd/button'
import {tab} from './_/tab/tab'
export default {
components:{
  AButton
}
setup:=>
  tab "同步状态"
  return
}
</script>

