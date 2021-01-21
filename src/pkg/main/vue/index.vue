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
  scrollbar
    feed
  me
</template>


<script lang="coffee">
import {add} from "@/ws/task"
import Scrollbar from '@/lib/scrollbar'
import DB from '@/db/rxdb'
import {onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'
import AButton from '@/lib/antd/button'
import Me from './_com/me'
import Feed from './_com/feed'
export default {
components:{
  AButton
  Me
  Scrollbar
  Feed
}
setup:=>
  {task} = DB

  onUnmounted =>
    console.log "cancel task"
    task$?.cancel()

  # setInterval(
  #   =>
  #     console.log DB
  #     console.log (await DB.task.find().exec()),"<<"
  #   3000
  li = shallowRef await DB.task.find().exec()

  task$ = await DB.task$()
  task.find(limit:4).sort('-id').$.subscribe (_li)=>
    console.log "subscribe", _li
    for i from _li
      console.log i._rev, i
    li.value = _li
  # state.active$.subscribe (active)=>
  #   console.log "active", active
  #
  # state.docs$.subscribe (doc)=>
  #   console.log "doc", doc
  #
  # state.change$.subscribe(
  #   (change) =>
  #     console.log("change", change)
  # )

  form = {
  }
  return {
    form: ref form
    li:li
    # rm:(key)=>
    #   console.log "rm", key
    #   await items.find(
    #     selector:{
    #       key
    #     }
    #   ).remove()
    # update:(key)=>
    #   await items.findOne(
    #     selector:{
    #       key
    #     }
    #   ).update(
    #     $set:
    #       value: (new Date()).toLocaleString()
    #   )
    #
    submit:=>
      await add(form.addr,form.key,form.url)
      return
  }

}
</script>

