<template lang="pug">
nav
  a(
    v-for="i in href"
    :href="base+i[0]"
    :class="{now:i[0]==now}"
  ) {{i[1]}}
</template>

<script lang="coffee">
export default {
props:
  base:
    type:String
    default:"/"
  href:Array
  now:String
}
</script>
