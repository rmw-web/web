<style lang="stylus" scoped>
@import '@/pkg/main/styl/ico/gg/add'
.page
  display flex
  top 0
  bottom 0
  left 0
  right 0
  position absolute
  overflow hidden
  &>aside, &>main
    box-sizing border-box
    display flex
    flex 1
  &>aside
    flex-direction column
    &>div
      position relative
      display flex
      &>textarea
        width 100%
        border none
        outline 0
        resize none
        height 3.4rem
        font-size 1rem
        box-shadow none
        line-height 1.8
        padding 1rem 1.8rem 0.8rem 1rem
        color #000
        /*
        &:invalid+.send
          display none
        */
      sendWidth = 1.4rem
      &>.send
        position absolute
        bottom 1.42rem
        width sendWidth
        height sendWidth
        right 0.6rem
        z-index 1
        &:after
          color #999
          font-size sendWidth
          content '\e601'
          font-family I
        &:hover
          &:after
            color #f40
            content '\e605'
    &>main
      display flex
      width 100%
      flex-direction column
      &>nav, &>nav>menu
        height 2.3rem
        line-height 2.5rem
        display flex
      &>input
        padding 0 0.8rem
        border 0
        border 1px solid #eee
        border-width 1px 0
      &>nav
        user-select none
        background #F9F9F9
        display flex
        justify-content space-between
        &>a
          transform scale(0.7)
          margin-left 0.35rem
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
    a(background:="safari-pinned-tab.svg")
    h1 我问问 h1
    a(href="/404") 404
  aside
    div
      a-textarea(required placeholder="写点什么 ？人民网络 ，畅所欲言 ···" :autosize="true")
      a.I.send
    main
      nav
        a
          b.gg.add
        menu
          a.now 更新
          a 我的
          a 留言
          //- a 统计信息
</template>


<script lang="coffee">
import {add} from "@/ws/task"
import DB from '@/db/rxdb'
import {onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'
import AButton from '@/lib/antd/button'
import AInput from '@/lib/antd/input'
export default {
components:{
  AButton
  ATextarea:AInput.TextArea
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

