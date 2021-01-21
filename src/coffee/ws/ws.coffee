import _on from '@/coffee/$/_on'
import split_n from 'split_n'
import throttle from 'lodash/throttle'

bind = (ws, method, li)=>
  ws.addEventListener method, (e)=>
    for i in li
      i.apply e

class Ws
  constructor: (@uri) ->
    #@event = {}
    #for k,v of event
    #  @event[k] = [v]

    #for k,v of {
    #  open: =>
    #    @_timer = setInterval(
    #      =>
    #        @ws.send '@'
    #      5000
    #    )
    #  message: ->
    #  close : =>
    #    @clearInterval @_timer
    #    @ws.close()
    #    @_ws()
    #}
    #  @event[k] = @event[k] or []
    #  @event[k].push v
    _new.call @
    @_next = throttle(_new.bind(@), 1000)
    @_id = 0
    @_todo = new Map()

  send: (msg)->
    @_send = new Date() - 0
    id = (++@_id).toString(36)
    _send @ws, id+" "+msg
    new Promise (resolve, reject)=>
      @_todo.set id, [msg, resolve, reject]

_send = (ws, msg)=>
  if ws and ws.readyState == WebSocket.OPEN
    ws.send msg

_new = ->
  if @ws and @ws <= WebSocket.OPEN
    @ws.close()

  @ws = ws = new WebSocket(@uri)
  _timer = @_recv = @_send = 0

  _wait = =>
    if ws.readyState > WebSocket.OPEN
      @_next()
    else
      _check()

  _check = =>
    _timer = setTimeout(
      _wait
      3000
    )
  _timer = setTimeout _wait, 500

  unbind = _on(
    ws
    {
      close:=>
        @_next()
      message:(e)=>
        clearTimeout(_timer)
        unbind()
        _on(
          ws
          close: =>
            @_next()
          message: (e)=>
            @_recv = new Date() - 0
            txt = e.data
            switch txt
              when "@"
              else
                [id, reply] = split_n(txt, " ", 2)
                {_todo} = @
                task = _todo.get id
                if task
                  _todo.delete id
                  if reply != undefined
                    if reply.charAt(0) == "X"
                      task[2] @uri+" ❌ "+JSON.parse(reply[1..]).toString()
                    else
                      task[1] JSON.parse(reply)
                  else
                    task[1]()

        )
        [interval] = JSON.parse(e.data)
        interval = interval * 1000

        @_recv = @_send = new Date() - 0

        checker = =>
          if ws.readyState > WebSocket.OPEN
            return
          now = new Date() - 0
          diff = parseInt( interval + @_send - now )
          if diff <= 100
            rdiff = @_send - @_recv
            if rdiff > interval
              @_next()
              return
            ws.send "@"
            @_send = now
            diff = interval
          setTimeout checker, diff

        setTimeout checker, interval

        for [id, [msg]] from @_todo
          ws.send id+" "+msg
    }
  )

    #for k,v of @event
    #  bind ws, k, v

export default Ws
