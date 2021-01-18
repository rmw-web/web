<style lang="stylus" scoped>
@import '@/pkg/main/styl/ico/gg/add'
.page
  &>aside, &>main
    display flex
    position absolute
    top 2.3rem
    bottom 0
  &>aside
    width 50%
    right 0
    &>footer
      display flex
      width 100%
      flex-direction column
      align-self flex-end
      &>nav, &>nav>menu, &>input
        height 2.3rem
        line-height @height
        display flex
      &>input
        padding 0 0.8rem
        border 0
        border 1px solid #eee
        border-width 1px 0
      &>nav
        background #F9F9F9
        display flex
        justify-content space-between
        &>a
          transform scale(0.7)
          color #777
          height 2.3rem
          line-height 2.3rem
          display flex
          align-items center
          justify-content center
          width 2.3rem
          &:hover
            color #f40
        &>menu
          &>a
            font-weight 500
            color #777
            padding 0 0.8rem
            font-size 0.75rem
            &:first-child
              padding-left 0.8rem
            &.now
              background #fff
              box-shadow 0 1px 4px inset #ddd
              color #555
            &:hover
              color #f40
  &>main
    border-right 1px solid #eee
    left 0
    right 50%
    position absolute
    padding 2.3rem
    display flex
    flex-direction column
    input
      width 100%
      padding 1rem
      border 2px solid #000
      &:focus
        border-color #06f
    form
      margin-top 2rem
  ol
    li
      a
        cursor pointer
      span, a
        margin-left 1rem
</style>

<template lang="pug">
.page
  main
    h1 我问问 h1
    a(href="/404") 404
  aside
    footer
      input(placeholder="想说什么 ···")
      nav
        a
          b.gg.add
        menu
          a.now 聊天室
          a 他关注
          a 订阅者
</template>


<script lang="coffee">
import {add} from "@/ws/task"
import DB from '@/db/rxdb'
import {onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'
import AButton from '@/lib/antd/button'

export default {
components:{
  AButton
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

