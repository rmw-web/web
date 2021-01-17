require('./init.styl')
import {start,done} from './src.coffee'

n = 0
t = 0

export inc = =>
  if not n
    t = setTimeout(
      =>
        start()
      300
    )
  n += 1
  return

export dec = (x=1)=>
  n -= x
  if n <= 0
    clearTimeout t
    done()
    n = 0
  return

export class Spin
  constructor:->
    @n = 0
    return

  inc:->
    @n += 1
    inc()
    return

  dec:->
    @n -= 1
    dec()
    return

  end:->
    dec @n
    @n = 0
    return
