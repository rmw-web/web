<style lang="stylus" scoped>
.spin
  margin auto !important
</style>

<template lang="pug">
article(v-if="htm" v-html="htm")
HttpSpin(v-else)
</template>

<script lang="coffee">
import HttpSpin from '@/pkg/_/http/spin'
import md from "@/coffee/md"
import {onMounted, ref} from 'vue'
import {get} from '@/coffee/api'

export default {
components:{
  HttpSpin
}
props:
  href : String
setup:=>
  htm = ref()
  onMounted ->
    txt = await (await fetch(@href)).text()
    htm.value = md txt
  {htm}
}
</script>
