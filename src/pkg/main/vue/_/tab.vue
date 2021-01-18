<style lang="stylus" scoped>
.nav.ant-dropdown-menu
  margin-top -5px
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
  b, menu a
    vertical-align bottom
  &>main>b, menu>a
    display inline-flex
    height calc(2.3rem - 1px)
    border-right 1px solid #eee
    cursor pointer
    font-weight 500
    align-items center
    position relative
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
menu
  display flex
  &>a
    padding 0
    width 2.3rem
    align-items center
    justify-content center
    color #777
main>b
  padding 0.15rem 0.75rem 0
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
      margin-top -0.1rem
      &:hover
        color #fff
        background #777
main>b>b>a, menu>a>b
  color #777
  height 100%
  transform scale(0.65)
main>b>b:hover>a, menu>a:hover>b
  color #333
</style>
<template lang="pug">
config-provider
  nav
    main
      menu
        a(v-for="(url,ico) in menu" :class="{now:url==pwd}" :href="`/${url}`")
          b.gg(:class="ico")
      b(v-for="[title,url],n in tab.li" :class="{now:url==pwd}" @click="goto(url)" :title="url")
        | {{title}}
        b
          a.gg.close(@click.stop="tab.x(n)")
    menu
      a-dropdown
        a.ant-dropdown-link
          b.gg.arrow-down
        template(#overlay)
          a-menu.nav
            a-menu-item
              a(href="/state") 同步状态
            a-menu-item
              a(href="/config") 系统设置
  slot
</template>

<script lang="coffee">
import ADropdown from "@/lib/antd/dropdown"
import {ConfigProvider} from 'ant-design-vue'
import AMenu from "@/lib/antd/menu"
import $state from '@/coffee/$/state'
import goto from "@/coffee/goto"
import {shallowRef, ref, onUnmounted} from 'vue'
import tab from './tab/tab'
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
    "msg"
    plus:"add"
  }
  pwd = shallowRef(location.pathname[1..])
  unbind = $state =>
    pwd.value = location.pathname[1..]
    return

  onUnmounted =>
    unbind()

  {
    menu
    pwd
    tab
    goto
  }
}
</script>

