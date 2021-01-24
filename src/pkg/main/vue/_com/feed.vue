<style lang="stylus" scoped>
main
  display flex
  flex-direction row
  flex-wrap wrap
  &>ul
    display flex
    flex-direction column
    list-style none
    color #000
    &>li, &>main
      background url("data:image/svg+xml;utf-8,<svg xmlns='http://www.w3.org/2000/svg' width='100%' height='1px'><line x1='0' y1='0' x2='100%' y2='0' stroke-dasharray='3,3' stroke='rgb(185,185,185)'></line></svg>") 0 100% no-repeat
    li
      width 100%
      padding 1.15rem
      &>main
        overflow hidden
        &>header
          margin-bottom -0.775rem
          margin-top -0.24rem
          display flex
          width 100%
          align-items baseline
          &>i
            font-style normal
            font-weight 600
            &>i
              font-size 0.8rem
              font-style normal
              margin-right -0.3rem
              &>a
                margin 0 0.3rem
                &:first-child
                  margin-left 0.6rem
          &>.rt, &>.rt b
            font-weight 300
          &>.rt
            user-select none
            line-height 1
            margin-left 0.6rem
            color #999
            font-size 0.8rem
            &>b
              cursor pointer
              margin-left 0.2rem
              &:hover
                color #f40
              &>b
                margin 0 0.1rem
            &>.I
              margin-left 0.1rem
              transform scale(0.8)
              display inline-block
              transform-origin 100% 83%
            &>a
              color #999
              &:hover
                color #f40
        &>.txt
          margin-top 0.575rem
        &>.txt>p, &>footer
          padding 0
          margin 0.575rem 0 0
        &>footer, &>header
          a
            color #000
            &:hover
              color #f40
        &>footer
          align-items center
          background url("data:image/svg+xml;utf-8,<svg xmlns='http://www.w3.org/2000/svg' width='100%' height='1px'><line x1='0' y1='0' x2='100%' y2='0' stroke-dasharray='3,3' stroke='rgb(185,185,185)'></line></svg>") 0 53% no-repeat
          display flex
          font-size 0.8rem
          font-weight 300
          justify-content space-between
          width 100%
          a, i
            color #999
          &>a
            padding-left 0.3rem
            font-family 'code'
          &>a, &>menu
            background #fff
          &>menu
            user-select none
            display flex
            &>i
              font-style normal
              border 1px solid #999
              font-size 1rem
              padding 0.25rem 0.5rem 0.2rem
              border-radius 1rem
              transform scale(0.5)
              transform-origin 50% 21%
              margin-bottom -0.7rem
              margin-left -0.8rem
              margin-right -0.2rem
              font-family 'code'
              letter-spacing 0.05rem
              cursor pointer
              transition all 0.3s
              font-weight bolder
              &:hover
                color #fff
                background #f40
                transform scale(0.6)
                border-color @background
                font-weight bold
            &>a
              width 1.5rem
              height @width
              display flex
              padding 0 1rem
              align-content center
              justify-content center
              &:hover
                color #f40
            &>a:first-child
              margin-left -0.55rem
    &>main
      &>a
        margin-left 10.1rem
        margin-bottom 1.65rem
        position relative
        color #999
        &:after
          position absolute
          content '··· ···'
          right -2.1rem
        &:hover
          color #f40
      &>li
        padding-top 0
        padding-left 5.5rem
        &>.ico
          margin-right 0.9rem
        &>main>footer>menu>a:first-child
          margin-left -0.5rem
      &>li:first-child
        padding-top 1.15rem
        padding-left 1.15rem
    &>main>li:first-child, li
      &>.ico
        margin-right 1.15rem
        background 50% 50% / cover no-repeat
        width 3.2rem
        height @width * 1.454
        float left
        box-shadow 0 0 0.3rem inset rgba(0, 0, 0, 0.5)
        display inline-block
</style>

<template lang="pug">
main
  ul
    template(v-for="i in li")
      li
        b.ico(:style="`background-image:url('//www.thiswaifudoesnotexist.net/example-${i+1000}.jpg')`")
        main
          header
            i
              a 雷君
              i
                a 北京
                | ·
                a 铜山软件
                | ·
                a 产品架构师
            b.rt
              a 王旭
              | 、
              a 张春燕
              b 等
                b 3
                | 人
              i.I.rt
          .txt
            p Android Studio启用新代号，新版本Arctic Fox（白狐）重点新特性一览！
            p
              | 目前Android Studio的最新稳定版本为4.1，4.2版本也已经发布到Beta渠道。但是4.2版本将会是Android Studio数字命名的最后一个版本了，此后，Google将采用新的命名规则来为Android Studio命名。更改第一个版本命名为Android Studio Arctic Fox(2020.3.1) ，目前，Android Studio Artic Fox已经登陆Canary频道，迭代至Canary3版本。
          footer
            menu
              a
                b.I.like
              a
                b.I.rt
              a
                b.I.reply
              i 13
            a 10:30
          .txt
            p 针对美国媒体有关中方推动中美高层会晤的报道，中国驻美使馆发言人指出该报道与事实不符，同时强调，好的中美关系，不仅符合两国人民根本利益，而且是国际社会的共同期待。
          footer
            menu
              a
                b.I.like
              a
                b.I.rt
              a
                b.I.reply
            a
              | 10:30
      main
        li
          b.ico(:style="`background-image:url('//www.thiswaifudoesnotexist.net/example-${i+400}.jpg')`")
          main
            header
              i
                a Timjintan
            .txt
              p
                | 和SnowFlake的类似功能的产品还是不少的，除了Amazon Redshift，还有Google BigQuery，Azure Synapse Analytics（Azure SQL数据仓库），Teradata Vantage和Oracle数据库以及TimeXtender的Discovery Hub等
            footer
              menu
                a
                  b.I.like
                a
                  b.I.rt
                a
                  b.I.reply
              a
                | 2019-10-21 10:30
        li
          b.ico(:style="`background-image:url('//www.thiswaifudoesnotexist.net/example-${i}.jpg')`")
          main
            header
              i
                a 张小丰
            .txt
              p
                | 请问竞争对手都有谁呢？谢谢
            footer
              menu
                a
                  b.I.like
                a
                  b.I.rt
                a
                  b.I.reply
              a
                | 20:79
        a
          | 等 32 条
        li
          b.ico(:style="`background-image:url('//www.thiswaifudoesnotexist.net/example-${i+400}.jpg')`")
          main
            header
              i
                a Timjintan
            .txt
              p
                | Snowflake的收费模式不是订阅费加专业服务费。这家公司是对客户的数据保存收费，数据可以是数据湖和经过一定处理的数据；另外就是对数据的传输收费；还有就是对数据的处理收费，处理就是萃取、转换并转换成有洞察力的数据；最后就是对数据的展示收费。所有的这些都是基于现在三个最大的基础服务提供商，包括aws、azure和google cloud。也就是说他赚的每一分钱，有一部分都要交给这三家公司的。
            footer
              menu
                a
                  b.I.like
                a
                  b.I.rt
                a
                  b.I.reply
                i 915
              a
                | 23:52
      li
        b.ico(:style="`background-image:url('//www.thiswaifudoesnotexist.net/example-${i+100}.jpg')`")
        main
          header
            i
              a Hugo Lowell
          .txt
            p
              | Breaking via NY Times: Jeffrey Clark, the acting head of the civil division at the Justice Department, schemed with Trump to oust AG Rosen and wield dept power to force Georgia to overturn election results.
          footer
            menu
              a
                b.I.like
              a
                b.I.rt
              a
                b.I.reply
            a
              | 10:30
      li
        b.ico(:style="`background-image:url('//www.thiswaifudoesnotexist.net/example-${i+200}.jpg')`")
        main
          header
            i
              a 阮一峰
          .txt
            p
              | 再说日本。
              | 日本仍用印章（包括个人），等级又森严，于是有公司推出电子印章和会议系统。卖点是：
              | 社长盖的章是正的，常务斜一点表示位置稍低，部长再斜一点表示更低，后面课长系长依次倾斜……
              | 开会时，系统会自动按照职位安排屏幕上的大小和位置
              | 因为疫情，这套系统销量增加30倍。
            p
              | 上次说要简化盖章的时候，一大帮印章协会的出来拉着几个议员反对啊，大家不用章了他们就没饭吃了还说什么传统啦巴拉巴拉的，最后也就不了了之了
          footer
            menu
              a
                b.I.like
              a
                b.I.rt
              a
                b.I.reply
            a
              | 10:30
</template>


<script lang="coffee">
import {onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'
export default {
components:{

}
setup:=>
  li = []
  begin = 10000 # parseInt Math.random() * (100000-101)
  n = begin - 100
  while ++n < begin
    li.push n

  {
    li
  }
}
</script>

