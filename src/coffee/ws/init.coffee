window.ME = {}
export default =>
  {me} = await import('@/ws/user')
  [id,name] = await me(ME.id)
  window.ME = {id,name}
  return

