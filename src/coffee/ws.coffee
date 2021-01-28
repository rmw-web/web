import URI from "@/config/ws.txt"
import {Ws,conn} from './ws/ws'

WS = undefined
export init = =>
  WS = new Ws(URI)
  conn.call WS

export default (mod)=>
  new Proxy(
    {}
    get: (self, name) =>
      ->
        msg = [
          mod
          name
        ]
        if arguments.length
          msg.push JSON.stringify(Array.from(arguments))[1...-1]
        WS.send msg.join(' ')
  )


