import split_n from 'split_n'

export default (li)=>
  z = []
  for i in li.split("\n")
    [k,v] = split_n i," ",2
    z.push [v,k]
  return z

