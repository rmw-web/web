<style lang="stylus" scoped>
:deep(form)
  margin 0
  background #fff
  user-select none
  padding 1rem 0.5rem 0.5rem
  &.ing
    filter grayscale(100%) brightness(98%)
    &
      cursor wait
    *
      pointer-events none
  h3
    margin 0 auto 0.2em
    text-align center
  button, input
    line-height 2rem
    border 1px solid #444
    color #444
  input + label
    position absolute
    font-size 0.5rem
    background #fff
    top 0
    left 1.35rem
    padding 0 0.1rem 0 0.2rem
    color #444
  input:hover
    color #333
    border-color #390
    & + label
      color #390
  input:focus
    color #000
    border-color @color
    & + label
      color #000
    &:hover
      border-color #390
      & + label
        color #390
  input:placeholder-shown + label
    display none
  input:disabled
    text-indent 2.85rem
  input:disabled, a.input
    display inline-block
    user-select none
    color #999
    position relative
    background #f9f9f9
    & + label
      text-align center
      user-select none
      font-size 1.2rem
      position absolute
      left 1rem
      color #444
      top 0.5rem
      border-right 1px solid #ccc
      line-height 2rem
      padding 0.55rem 0.6rem 0.45rem
      border-left 1px solid #ccc
      border-top 1px solid #ccc
      background #fafafa
    &:hover
      border 1px solid #ccc
  a.input
    text-indent 2.25rem
    justify-content center
    &:hover
      background transparent
      color #f40
  button
    margin auto
    user-select none
    font-size 1.1rem
    cursor pointer
    outline 0
    padding 0.4rem 0 0.2rem
    display block
    background transparent
    width 100%
    text-align center
    &:focus
      color #000
      border-color #000
    &:hover
      background #f40
      border 1px solid #f40
      color #fff
    &:active
      box-shadow 0 0 0.3rem #000 inset
  button[disabled]
    &, &:hover, &:focus, &:active
      box-shadow none
      background #f5f5f5
      color #000
      border-color #f0f0f0
      cursor not-allowed
  li, footer
    padding 0.5rem 1rem
  footer
    font-size 0.9rem
    display flex
    justify-content space-between
    button
      margin-bottom 0.3rem
  li
    list-style none
    position relative
    &>input, &>a.input
      display flex
      width 15rem
      line-height 2rem
      border 1px solid #ccc
      padding 0.55rem 0.6rem 0.45rem
      outline 0
  mark
    color #f00
    font-size 0.9rem
    padding 0 calc(0.6rem + 1px)
    background transparent
    border none
    display block
    margin 0 0 -0.1rem
    padding-top 0.6rem
    font-weight bold
    &.op
      font-weight 200
      color #F44
</style>

<template lang="pug">
form(ref="form")
  slot
</template>

<script lang="coffee">
import focus from "@/coffee/focus"
export default {
setup:focus
}
</script>
