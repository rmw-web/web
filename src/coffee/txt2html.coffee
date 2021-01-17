import {escape} from 'lodash'

export default (txt)->
  r = []
  for i in txt.replace(/\r\n/g, "\n").replace(/\r/g, "\n").split("\n")
      r.push(escape i)
  return "<p>" + (r.join("</p><p>")) + "</p>"
