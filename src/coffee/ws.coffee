import URI from "@/config/ws.txt"
import Ws from './ws/ws'

WS = new Ws(
  URI
)

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


