window.ME = {}
export default =>
  me = (await import('@/ws/me')).default
  [id,name] = await me(ME.id)
  window.ME = {id,name}
  return

