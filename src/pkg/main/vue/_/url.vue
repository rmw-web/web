<style lang="stylus" scoped></style>

<template lang="pug">
Tab
  Suspense
    template(#default)
      component(:is="i")
    template(#fallback)
      HttpSpin
</template>

<script lang="coffee">
import HttpSpin from '@/pkg/_/http/spin'
import {shallowRef} from 'vue'
import route from '@/coffee/route'
import url from "../../coffee/url"
import Tab from "./tab"

export default {
components:{
  HttpSpin
  Tab
}
setup : =>
  route  "main", {
    i : shallowRef HttpSpin
  }
}
</script>

