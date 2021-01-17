export get = (key)=>
  localStorage.getItem key

export rm = (key)=>
  localStorage.removeItem key

export set = (key,val)=>
  localStorage.setItem key,val

