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
  feed(ref="feed")
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
  Feed
  Scrollbar
}
setup:(props,{emit})=>
  me = shallowRef()
  feed = shallowRef()

  onMounted =>
    emit 'scrollbar', [me.value.scroll, feed.value.scroll]
    return

  return {
    me
    feed
  }

}
</script>

