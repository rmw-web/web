<style lang="stylus" scoped>
.page
  display flex
  top 0
  bottom 0
  left 0
  right 0
  position absolute
  overflow hidden
  &>main
    box-sizing border-box
    border-right 1px solid #eee
    display flex
    flex-direction column
  &>.scrollbar, &>main
    flex 1
</style>

<template lang="pug">
.page
  me(ref="me")
  scrollbar(ref="scrollbar")
    trend
</template>


<script lang="coffee">
import Scrollbar from '@/lib/scrollbar'
import {onMounted, onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'
import Me from './_com/me'
import Trend from './_com/trend'
export default {
components:{
  Me
  Trend
  Scrollbar
}
setup:(props,{emit})=>
  me = shallowRef()
  scrollbar = shallowRef()

  onMounted =>
    emit 'scrollbar', [me.value.scroll, scrollbar.value]
    return

  return {
    me
    scrollbar
  }

}
</script>

