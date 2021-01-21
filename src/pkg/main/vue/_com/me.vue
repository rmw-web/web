<style lang="stylus" scoped>
@import '@/pkg/main/styl/ico/gg/add'
main
  &>header
    position relative
    display flex
    &>textarea
      width 100%
      border none
      outline 0
      resize none
      height 3.4rem
      font-size 1rem
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
  &>nav, &>nav>menu
    height 2.3rem
    line-height 2.5rem
    display flex
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
        font-weight 400
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
</style>

<template lang="pug">
main
  header
    a-textarea(required placeholder="写点什么 ？人民网络 ，畅所欲言 ···" :autoSize="true")
    a.I.send(title="快捷键 Ctrl+Enter")
  nav
    a
      b.gg.add
    menu
      a.now 更新
      a 我的
      a 留言
      //- a 统计信息
  div
</template>


<script lang="coffee">
import AInput from '@/lib/antd/input'

export default {
components:{
  ATextarea:AInput.TextArea
}
setup:=>

}
</script>

