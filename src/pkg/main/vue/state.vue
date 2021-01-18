<style lang="stylus" scoped>
.page
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
    form(@submit.prevent="submit")
      p
        input(placeholder="节点网址" type=text v-model="form.addr")
      p
        input(placeholder="站点公钥" v-model="form.key")
      p
        input(placeholder="文件路径" v-model="form.url")
      p
        a-button(type="primary") 参数
      p
        button(type="submit") 添加下载
    ol
      li(v-for="i in li")
        | {{i.time}}
        span {{i.url}}
        a(@click="rm(i.key)") X
        button(@click="update(i.key)") 更新
    pre
      | def test
      |    pass
    code
      | def test
      |    pass
    footer
      a(href="/404") 404
</template>


<script lang="coffee">
import {add} from "@/ws/task"
import DB from '@/db/rxdb'
import {onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'
import AButton from '@/lib/antd/button'
import {tab} from './_/tab/tab'
export default {
components:{
  AButton
}
setup:=>
  tab "同步状态"
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
    addr:"p4bHzAquvx_5h_tK5j-WpQokOhv7JteHbPfADIIP2bQ"
    key:"p4bHzAquvx_5h_tK5j-WpQokOhv7JteHbPfADIIP2bQ"
    url:"xaa"
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

