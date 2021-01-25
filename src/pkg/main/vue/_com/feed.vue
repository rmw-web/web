<style lang="stylus" scoped>
@import '@/pkg/main/styl/ico/gg/add'
main
  &>header
    position relative
    display flex
  &>nav, &>nav>menu
    height 2.3rem
    line-height 2.5rem
    display flex
  &>nav
    user-select none
    display flex
    box-shadow 0 0 0.2rem #ddd
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
        color #777
        padding 0 0.8rem
        font-size 0.75rem
        &>b
          font-weight 400
        &:first-child
          padding-left 0.8rem
        &.now
          background #fff
          color #333
          &>b
            font-weight 600
        &:hover
          color #f40
main>nav>menu>a>b>i.at
  font-size 0.9rem
  font-style normal
  vertical-align -0.05rem
</style>

<template lang="pug">
main
  nav
    menu
      a.now
        b 动态
      a
        b
          i.at ＠
          | 我
      a
        b 评论
      a
        b 我的
      a
        b 转发
      a
        b 点赞
      //- a 统计报表
    a
      b.gg.add
  scrollbar(ref="scroll")
    msg(:li="li")
</template>


<script lang="coffee">
import AInput from '@/lib/antd/input'
import Scrollbar from '@/lib/scrollbar'
import {shallowRef} from 'vue'
import Msg from './msg'

export default {
components:{
  ATextarea:AInput.TextArea
  Scrollbar
  Msg
}
setup:=>
  scroll = shallowRef()
  user = {
    9000:[
      "雷君"
      [
        "北京"
        "铜山软件"
        "产品架构师"
      ]
    ]
  }

  li= [
    [
      9000 # 发布人
      [
        "现在好像文学艺术式微了。还有多少人会去看木偶剧、话剧、舞剧、魔术、杂技、篆刻、书法？" # 内容正文
        1611483961 # 发布时间
        13 # 留言数
        [
          [ 12131,"王旭" ]
          [ 12132,"张春燕" ]
        ]
        32 # 等 32 人转发
      ]
    ]
  ]
  begin = 60000
  li = [begin..begin+300]
  {
    li
    scroll
  }
}
</script>

