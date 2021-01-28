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
  HttpSpin(v-else)
</template>


<script lang="coffee">
import Scrollbar from '@/lib/scrollbar'
import {onMounted, onUnmounted, nextTick, shallowRef, onBeforeMount, ref} from 'vue'
import HttpSpin from '@/pkg/_/http/spin'
import Feed from './_com/feed'
export default {
components:{
  Feed
  HttpSpin
  Scrollbar
}
setup:(props,{emit})=>
  me = shallowRef()
  feed = shallowRef()

  emitS = (c)=>
    emit 'scrollbar', c

  onMounted =>
    emitS feed.value.scroll
    page = "me"
    if not ME.id
      page += "/init"
    mod = (await import("./_com/"+page)).default
    {setup} = mod
    mod.setup = =>
      r = setup()
      nextTick =>
        emitS r.scroll.value
      r
    me.value = mod

    return

  return {
    me
    feed
  }

}
</script>

