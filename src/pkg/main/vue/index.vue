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
    border-left 1px solid #eee
    display flex
    flex-direction column
  &>.scrollbar, &>main
    flex 1
</style>

<template lang="pug">
.page
  scrollbar(ref="scrollbar")
    feed(:li="[5000,5001,5002,5003,5004,5005]")
  me(ref="me")
</template>


<script lang="coffee">
import Scrollbar from '@/lib/scrollbar'
import {onMounted, onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'
import Me from './_com/me'
import Feed from './_com/feed'
export default {
components:{
  Me
  Scrollbar
  Feed
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

