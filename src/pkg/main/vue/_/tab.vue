<style lang="stylus" scoped>
@import '@/pkg/main/styl/ico/gg/plus'
@import '@/pkg/main/styl/ico/gg/close'
@import '@/pkg/main/styl/ico/gg/bookmark'
@import '@/pkg/main/styl/ico/gg/ghost'
@import '@/pkg/main/styl/ico/gg/msg'
@import '@/pkg/main/styl/ico/gg/arrow-down'
fontSize = 0.75rem
nav
  background #F9F9F9
  border-bottom 1px solid #eee
  display flex
  font-size fontSize
  justify-content space-between
  height 2.3rem
  line-height @height
  position absolute
  top 0
  user-select none
  width 100%
  &>main
    display flex
  b
    position relative
    height calc(2.3rem - 1px)
    border-right 1px solid #eee
    display inline-block
    cursor pointer
    font-weight 500
    align-items center
    padding 0 0.75rem
    line-height 2.4rem
    vertical-align bottom
    &:hover
      background #f0f0f0
      font-weight 500
      color #333
    &.now
      height 2.3rem
      color #000
      background #fff
      margin-bottom -1px
      padding-bottom 1px
.nav.ant-dropdown-menu
  margin-top -5px
menu
  display flex
  &>b
    padding 0
    display flex
    width 2.3rem
    align-items center
    justify-content center
    color #777
b
  &>b
    height 2.3rem
    position relative
    right -0.5rem
    border none
    display inline-flex
    align-items center
    padding 0
    justify-content center
    &:hover
      background transparent
    &>.gg.close
      margin-top -0.23rem
      &:hover
        color #fff
        background #777
  &>a
    color #777
    height 100%
    transform scale(0.65)
  &:hover
    &>a
      color #333
</style>
<template lang="pug">
config-provider
  nav
    main
      menu
        b(v-for="(url,ico) in menu")
          a.gg(:href="`/${url}`" :class="ico")
        b
          a.gg.ghost
        b
          a.gg.im
        b
          a.gg.plus
      b.now 人民网络
        b
          a.gg.close
      b 十万个冷笑话
        b
          a.gg.close
      b Stack OverOverflow
        b
          a.gg.close
    menu
      a-dropdown
        b.ant-dropdown-link
          a.gg.arrow-down
        template(#overlay)
          a-menu.nav
            a-menu-item
              a(href="/state") 同步状态
  slot
</template>

<script lang="coffee">
import ADropdown from "@/lib/antd/dropdown"
import {ConfigProvider} from 'ant-design-vue'
import AMenu from "@/lib/antd/menu"
import {shallowRef, ref} from 'vue'
#import {onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'

export default {
components:{
  ConfigProvider
  ADropdown
  AMenu
  AMenuItem:AMenu.Item
}
setup:=>
  menu = {
    bookmark:""
    ghost:"blog"
    plus:"add"
    "msg"
  }
  {
    menu: shallowRef menu
  }
}
</script>

