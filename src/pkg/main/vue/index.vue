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
  feed(ref="feed")
  component(v-if="me" :is="me")
  main(v-else)
</template>


<script lang="coffee">
import Scrollbar from '@/lib/scrollbar'
import {onMounted, onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'
# import Me from
import Feed from './_com/feed'
export default {
components:{
  Feed
  Scrollbar
}
setup:(props,{emit})=>
  me = shallowRef()
  feed = shallowRef()

  scrollbar = []
  onMounted =>
    scrollbar.push feed.value.scroll
    emit 'scrollbar', scrollbar
    me.value  = _me = (await import("./_com/me")).default
    scrollbar.push _me.scrollbar
    return

  return {
    me
    feed
  }

}
</script>

