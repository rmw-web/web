#!/usr/bin/env coffee

css = {
  shadow:
    1:
      up: "0 0 2px rgba(0, 0, 0, 0.1)"
      down: "0 0 2px rgba(0, 0, 0, 0.1)"
      left: "0 0 2px rgba(0, 0, 0, 0.1)"
      right: "0 0 2px rgba(0, 0, 0, 0.1)"
  primary:
    color: '#1269D3'
  link:{
  }
  font:
    family: "html,sans-serif"
  btn:
    border:
      radius:
        sm: 0
        base: 0
  border:
    radius:
      sm: 0
      base: 0
}

css.link.color = css.primary.color

vars = (o, prefix="")=>
  r = {}
  for i of o
    v = o[i]
    if typeof(v) != 'object'
      r[prefix+i] = v
    else
      Object.assign r, vars(v, prefix+i+"-")
  r

css = vars css
if module?.exports
  module.exports = css
else
  console.log css
