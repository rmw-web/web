window.USER = {}
export default =>
  {login} = await import('@/ws/user')
  [id,name] = await login(USER.id)
  window.USER = {id,name}
  return

