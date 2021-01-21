<style lang="stylus" scoped>
$l-purple = #fff
$color = #fc0
$eye = #333
main
  h1, .box
    margin auto
  h1
    color $color
    font-size 3rem
    margin 2rem auto 5rem
    letter-spacing 0.3rem
p, .box__ghost-container
  animation upndown 3s ease-in-out infinite
.box
  .box__ghost
    padding 1rem 2rem
    position relative
    left 50%
    top 50%
    transform translate(-50%, -30%)
    .symbol
      &:nth-child(1)
        opacity 0.2
        animation shine 4s ease-in-out 3s infinite
        &:before, &:after
          content ''
          width 12px
          height 4px
          background $color
          position absolute
          border-radius 5px
          bottom 65px
          left 0
        &:before
          transform rotate(45deg)
        &:after
          transform rotate(-45deg)
      &:nth-child(2)
        position absolute
        left -5px
        top 30px
        height 18px
        width 18px
        border 4px solid
        border-radius 50%
        border-color $color
        opacity 0.2
        animation shine 4s ease-in-out 1.3s infinite
      &:nth-child(3)
        opacity 0.2
        animation shine 3s ease-in-out 0.5s infinite
        &:before, &:after
          content ''
          width 12px
          height 4px
          background $color
          position absolute
          border-radius 5px
          top 5px
          left 40px
        &:before
          transform rotate(90deg)
        &:after
          transform rotate(180deg)
      &:nth-child(4)
        opacity 0.2
        animation shine 6s ease-in-out 1.6s infinite
        &:before, &:after
          content ''
          width 15px
          height 4px
          background $color
          position absolute
          border-radius 5px
          top 10px
          right 30px
        &:before
          transform rotate(45deg)
        &:after
          transform rotate(-45deg)
      &:nth-child(5)
        position absolute
        right 5px
        top 40px
        height 12px
        width 12px
        border 3px solid
        border-radius 50%
        border-color $color
        opacity 0.2
        animation shine 1.7s ease-in-out 7s infinite
      &:nth-child(6)
        opacity 0.2
        animation shine 2s ease-in-out 6s infinite
        &:before, &:after
          content ''
          width 15px
          height 4px
          background $color
          position absolute
          border-radius 5px
          bottom 65px
          right -5px
        &:before
          transform rotate(90deg)
        &:after
          transform rotate(180deg)
    .box__ghost-container
      background $color
      width 100px
      height 100px
      border-radius 100px 100px 0 0
      position relative
      margin 0 auto
      .box__ghost-eyes
        z-index 9
        position absolute
        left 50%
        top 45%
        // transform: translate(-50%, -45%);
        height 12px
        width 70px
        .box__eye-left
          width 12px
          height 12px
          background $eye
          border-radius 50%
          margin 0 10px
          position absolute
          left 0
        .box__eye-right
          width 12px
          height 12px
          background $eye
          border-radius 50%
          margin 0 10px
          position absolute
          right 0
      .box__ghost-bottom
        display flex
        position absolute
        top 100%
        left 0
        right 0
        div
          flex-grow 1
          position relative
          top -10px
          height 20px
          border-radius 100%
          background-color $color
          &:nth-child(2n)
            top -12px
            margin 0 0px
            border-top 15px solid $l-purple
            background transparent
    .box__ghost-shadow
      height 20px
      box-shadow 0 50px 15px 5px #aaa
      border-radius 50%
      margin 0 auto
      animation smallnbig 3s ease-in-out infinite
// keyframes
@keyframes upndown
  0%
    transform translateY(5px)
  50%
    transform translateY(15px)
  100%
    transform translateY(5px)
@keyframes smallnbig
  0%
    width 90px
  50%
    width 100px
  100%
    width 90px
@keyframes shine
  0%
    opacity 0.3
  25%
    opacity 0.1
  50%
    opacity 0.3
  100%
    opacity 0.3
</style>
<template lang="pug">
X
  h1(v-html="state")
  .box
    .box__ghost
      .symbol
      .symbol
      .symbol
      .symbol
      .symbol
      .symbol
      .box__ghost-container
        .box__ghost-eyes(ref="eye")
          .box__eye-left
          .box__eye-right
        .box__ghost-bottom
          div
          div
          div
          div
          div
      .box__ghost-shadow
</template>

<script lang="coffee">
import {shallowRef,reactive,onMounted,onUnmounted} from 'vue'
import $on from '@/coffee/$/on'
import X from "@/pkg/_/x"

export default {
components:{
  X
}
setup : =>
  state = '页面不存在'
  doc = document
  doc.title = state
  doc = doc.documentElement
  pageX = doc.offsetWidth
  pageY = doc.offsetHeight
  mouseY=0
  mouseX=0
  eye = shallowRef(null)

  onMounted =>
    eye = eye.value

  $on doc,{
    mousemove :(event) =>
      mouseY = event.pageY
      mouseX = event.pageX / -pageX
      yAxis = -(pageY/2-mouseY)/pageY*400 - 100
      xAxis = -mouseX * 100 - 100
      eye.style = "transform:translate(#{xAxis}%,#{yAxis}%)"
      return

  }

  {
    state
    eye
  }
}
</script>
