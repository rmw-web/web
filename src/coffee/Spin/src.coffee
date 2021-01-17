Setting_minimum= 0.08
Setting_easing= 'linear'
Setting_positionUsing= ''
Setting_speed= 200
Setting_trickle= true
Setting_trickleSpeed= 200
Setting_barSelector= '[role="bar"]'
Setting_spinnerSelector= '[role="spinner"]'
BODY = document.body
Setting_template= '<div class="bar" role="bar"><div class="peg"></div></div><div class="spinner" role="spinner"><div class="spinner-icon"></div></div>'
clamp = (n, min, max) ->
    if n < min
        return min
    if n > max
        return max
    n

###*
# (Internal) converts a percentage (`0..1`) to a bar translateX
# percentage (`-100%..0%`).
###

toBarPerc = (n) ->
    (-1 + n) * 100

###*
# (Internal) returns the correct CSS for changing the bar's
# position given an n percentage, and speed and ease from Settings
###

barPositionCSS = (n, speed, ease) ->
    barCSS = transform: 'translate3d(' + toBarPerc(n) + '%,0,0)'
    barCSS.transition = 'all ' + speed + 'ms ' + ease
    barCSS

###*
# (Internal) Determines if an element or space separated list of class names contains a class name.
###


addClass = (element, name) ->
  element.classList.add name

removeClass = (element, name) ->
  element.classList.remove name

removeElement = (element) ->
    element and element.parentNode and element.parentNode.removeChild(element)
    return

###*
# Last number.
###

NProgress_status = null

###*
# Sets the progress bar status, where `n` is a number from `0.0` to `1.0`.
#
#     NProgress_set(0.4);
#     NProgress_set(1.0);
###

NProgress_set = (n) ->
    started = NProgress_isStarted()
    n = clamp(n, Setting_minimum, 1)
    NProgress_status = if n == 1 then null else n
    progress = NProgress_render(!started)
    bar = progress.querySelector(Setting_barSelector)
    speed = Setting_speed
    ease = Setting_easing
    progress.offsetWidth

    ### Repaint ###

    queue (next) ->
        # Set positionUsing if it hasn't already been set
        Setting_positionUsing = 'translate3d'
        # Add transition
        css bar, barPositionCSS(n, speed, ease)
        if n == 1
            # Fade out
            css progress,
                transition: 'none'
                opacity: 1
            progress.offsetWidth

            ### Repaint ###

            setTimeout (->
                css progress,
                    transition: 'all ' + speed + 'ms linear'
                    opacity: 0
                setTimeout (->
                    NProgress_remove()
                    next()
                    return
                ), speed
                return
            ), speed
        else
            setTimeout next, speed
        return
    this

NProgress_isStarted = ->
    typeof NProgress_status == 'number'

###*
# Shows the progress bar.
# This is the same as setting the status to 0%, except that it doesn't go backwards.
#
#     start();
#
###

export start = ->
    if !NProgress_status
        NProgress_set 0

    work = ->
        setTimeout (->
            if !NProgress_status
                return
            NProgress_trickle()
            work()
            return
        ), Setting_trickleSpeed
        return

    if Setting_trickle
        work()
    this

###*
# Hides the progress bar.
# This is the *sort of* the same as setting the status to 100%, with the
# difference being `done()` makes some placebo effect of some realistic motion.
#
#     done();
#
# If `true` is passed, it will show the progress bar even if its hidden.
#
#     done(true);
###

export done = (force) ->
    if !force and !NProgress_status
        return this
    NProgress_inc(0.3 + 0.5 * Math.random())
    NProgress_set 1

###*
# Increments by a random amount.
###

NProgress_inc = (amount) ->
    n = NProgress_status
    if !n
        start()
    else if n > 1
        return
    else
        if typeof amount != 'number'
            if n >= 0 and n < 0.2
                amount = 0.1
            else if n >= 0.2 and n < 0.5
                amount = 0.04
            else if n >= 0.5 and n < 0.8
                amount = 0.02
            else if n >= 0.8 and n < 0.99
                amount = 0.005
            else
                amount = 0
        n = clamp(n + amount, 0, 0.994)
        NProgress_set n

NProgress_trickle = ->
    NProgress_inc()

###*
# Waits for all supplied jQuery promises and
# increases the progress as the promises resolve.
#
# @param $promise jQUery Promise
###

do ->
    initial = 0
    current = 0

    NProgress_promise = ($promise) ->
        if !$promise or $promise.state() == 'resolved'
            return this
        if current == 0
            start()
        initial++
        current++
        $promise.always ->
            current--
            if current == 0
                initial = 0
                done()
            else
                NProgress_set (initial - current) / initial
            return
        this

    return

###*
# (Internal) renders the progress bar markup based on the `template`
# setting.
###

NProgress_render = (fromStart) ->
    progress = document.getElementById('nprogress')
    if progress
      return progress
    addClass document.documentElement, 'nprogress-busy'
    progress = document.createElement('div')
    progress.id = 'nprogress'
    progress.innerHTML = Setting_template
    bar = progress.querySelector(Setting_barSelector)
    perc = if fromStart then '-100' else toBarPerc(NProgress_status or 0)
    parent = BODY
    spinner = undefined
    css bar,
        transition: 'all 0 linear'
        transform: 'translate3d(' + perc + '%,0,0)'
    if parent != document.body
        addClass parent, 'nprogress-custom-parent'
    parent.appendChild progress
    progress

###*
# Removes the element. Opposite of render().
###

NProgress_remove = ->
    removeClass document.documentElement, 'nprogress-busy'
    removeClass BODY, 'nprogress-custom-parent'
    progress = document.getElementById('nprogress')
    progress and removeElement(progress)
    return



###*
# (Internal) Queues a function to be executed.
###

queue = do ->
    pending = []

    next = ->
        fn = pending.shift()
        if fn
            fn next
        return

    (fn) ->
        pending.push fn
        if pending.length == 1
            next()
        return

###*
# (Internal) Applies css properties to an element, similar to the jQuery
# css method.
#
# While this helper does assist with vendor prefixed property names, it
# does not perform any manipulation of values prior to setting styles.
###

css = do ->
    cssProps = {}

    camelCase = (string) ->
        string.replace /-([\da-z])/gi, (match, letter) =>
          letter.toUpperCase()

    getVendorProp = (name) ->
        style = document.body.style
        if name of style
            return name
        name

    getStyleProp = (name) ->
        name = camelCase(name)
        cssProps[name] or (cssProps[name] = getVendorProp(name))

    applyCss = (element, prop, value) ->
        prop = getStyleProp(prop)
        element.style[prop] = value
        return

    (element, properties) ->
        args = arguments
        prop = undefined
        value = undefined
        if args.length == 2
            for prop of properties
                `prop = prop`
                value = properties[prop]
                if value != undefined and properties.hasOwnProperty(prop)
                    applyCss element, prop, value
        else
            applyCss element, args[1], args[2]
        return
