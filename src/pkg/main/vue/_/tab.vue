<style lang="stylus" scoped>
.nav.ant-dropdown-menu
  margin-top -5px
@import '@/pkg/main/styl/ico/gg/msg'
@import '@/pkg/main/styl/ico/gg/plus'
@import '@/pkg/main/styl/ico/gg/close'
@import '@/pkg/main/styl/ico/gg/bookmark'
@import '@/pkg/main/styl/ico/gg/ghost'
@import '@/pkg/main/styl/ico/gg/arrow-down'
fontSize = 0.75rem
headerHeight = 2.3rem
headerBg = #F9F9F9
body>main>.page
  position absolute
  top 0
  bottom 0
  left 0
  right 0
  transition top 0.3s
body>main>.page>.scrollbar, body>main>.page>header
  position absolute
body>main>.page>.scrollbar
  background #fff
  top headerHeight
  left 0
  right 0
  bottom 0
  z-index 1
  display flex
body>main>.page>header
  background headerBg
  border-bottom 1px solid #eee
  display flex
  font-size fontSize
  height headerHeight
  justify-content space-between
  line-height @height
  top 0
  user-select none
  width 100%
  &>nav
    display flex
  b, menu a
    vertical-align bottom
  &>nav>b, menu>a
    display inline-flex
    height calc(2.3rem - 1px)
    border-right 1px solid #eee
    cursor pointer
    font-weight 400
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
nav>b
  padding 0.15rem 0.75rem 0
  &>span
    display inline-block
    overflow hidden
    white-space nowrap
    max-width 10rem
    text-overflow ellipsis
  &>b
    height 2.3rem
    position relative
    right -0.5rem
    margin-left -0.3rem
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
nav>b>b>a, menu>a>b
  color #777
  height 100%
  transform scale(0.65)
nav>b>b:hover>a, menu>a:hover>b
  color #333
</style>
<template lang="pug">
config-provider(:locale="locale")
  .page(ref="page")
    header(ref="header")
      nav
        menu
          a(v-for="(url,ico) in menu" :class="{now:url==pwd}" :href="`/${url}`")
            b.gg(:class="ico")
        b
          span 在微软（Microsoft）工作是怎样一番体验？
          b
            a.gg.close(@click.stop="tab.x(n)")
        b(v-for="[title,url],n in tab.li" :class="{now:url==pwd}" @click="goto(url)" :title="url")
          span {{title}}
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
    scrollbar(ref="main")
      slot
</template>

<script lang="coffee">
import throttle from 'lodash/throttle'
import Scrollbar from '@/lib/scrollbar'
import ADropdown from "@/lib/antd/dropdown"
import {ConfigProvider} from 'ant-design-vue'
import AMenu from "@/lib/antd/menu"
import $state from '@/coffee/$/state'
import $on from '@/coffee/$/on'
import goto from "@/coffee/goto"
import {shallowRef, onMounted, ref, onUnmounted} from 'vue'
import tab from './tab/tab'
#import {onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'
#import zhCN from 'ant-design-vue/es/locale/zh_CN'

export default {
components:{
  ConfigProvider
  ADropdown
  AMenu
  AMenuItem:AMenu.Item
  Scrollbar
}
setup:=>
  menu = {
    "msg"
    bookmark:"fav"
    ghost:""
    plus:"add"
  }
  pwd = shallowRef(location.pathname[1..])
  main = shallowRef()
  header = shallowRef()
  page = shallowRef()

  isHide = false

  autohide = (m)=>
    mv = m.$el
    pv = page.value
    {offsetTop} = mv
    pren = 0
    prediff = 0
    pre = 0
    $on(
      mv
      scroll:throttle(
        ->
          {scrollTop} = mv
          diff = scrollTop - pre
          if diff > 0
            if not isHide
              if prediff <= 0
                pren = scrollTop
              else if pv.offsetTop == 0
                if scrollTop - pren > 99
                  pv.style.top = -header.value.clientHeight+"px"
                  isHide = true
          else if isHide
            s99 = scrollTop > 99
            if prediff >= 0 and s99
              pren = scrollTop
            else if pv.offsetTop < 0
              if (not s99) or pren - offsetTop > 99
                isHide = false
                pv.style.top = 0

          pre = scrollTop
          prediff = diff
          return
        300
      )

      )


  $state =>
    pwd.value = location.pathname[1..]
    return

  locale = shallowRef {}
  onMounted =>
    autohide main.value
    lang = navigator.language.replace("-","_")
    try
      locale.value = (await import('ant-design-vue/es/locale/'+lang+".js")).default
    catch err
      console.error err
    return
  {
    menu
    page
    main
    autohide
    pwd
    tab
    header
    goto
    locale
  }
}
</script>

