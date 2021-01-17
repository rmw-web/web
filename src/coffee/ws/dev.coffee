import Ws from '@/coffee/ws'
_task = Ws('task')
_rxdb = Ws('rxdb')
_env = Ws('env')
export default {
env:{
  test : () -> console.log await _env.test.apply(_env, arguments)
  xx : (a, b, c = 1) -> console.log await _env.xx.apply(_env, arguments)
  xxx : () -> console.log await _env.xxx.apply(_env, arguments)
}
rxdb:{
  schema : () -> console.log await _rxdb.schema.apply(_rxdb, arguments)
}
task:{
  add : (addr, key, url) -> console.log await _task.add.apply(_task, arguments)
  li : () -> console.log await _task.li.apply(_task, arguments)
}
}