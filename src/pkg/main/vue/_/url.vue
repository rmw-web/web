<style lang="stylus" scoped></style>

<template lang="pug">
Tab(ref="tab")
  Suspense
    template(#default)
      component(:is="i" @scrollbar="scrollbar")
    template(#fallback)
      HttpSpin
</template>

<script lang="coffee">
import HttpSpin from '@/pkg/_/http/spin'
import {shallowRef, ref} from 'vue'
import route from '@/coffee/route'
import url from "../../coffee/url"
import Tab from "./tab"

export default {
components:{
  HttpSpin
  Tab
}
setup : =>
  tab = ref()
  route  "main", {
    tab
    scrollbar:(li)=>
      {autohide} = tab.value
      for s from li
        autohide s
      return
    i : shallowRef HttpSpin
  }
}
</script>

