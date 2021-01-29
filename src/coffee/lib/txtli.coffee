import split_n from 'split_n'

export default (li)=>
  z = []
  for i in li.split("\n")
    z.push split_n i," ",2
  return z

