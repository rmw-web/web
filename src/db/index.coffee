import {onMounted,ref} from 'vue'
import DB from '@/db'
import * as WsIndex from '@/ws/index'

export default =>
  com = ref()
  onMounted =>
    db = await DB.index(
      li:''
    )
    console.log db
    com.value = await WsIndex.li()
  {
    com
  }