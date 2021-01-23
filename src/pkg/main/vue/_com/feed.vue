<style lang="stylus" scoped>
main
  display flex
  flex-direction row
  flex-wrap wrap
  .ico
    background 50% 50% / 8rem
    margin 1rem
    width 6rem
    float left
    box-shadow 0 0 0.3rem inset rgba(0, 0, 0, 0.5)
    height @width
    display inline-block
  form
    margin-top 2rem
</style>

<template lang="pug">
main
  .bk(v-for="i in li")
    b.ico(:style="`background-image:url('//www.thiswaifudoesnotexist.net/example-${i}.jpg')`")

</template>


<script lang="coffee">
import {onUnmounted, shallowRef, onBeforeMount, ref} from 'vue'
export default {
components:{

}
setup:=>
  li = [1..100000]
  {
    li
  }
}
</script>

