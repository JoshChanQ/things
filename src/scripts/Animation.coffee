# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  'use strict'

  animations = []
  animIdCounter = 0
  animRunning = false

  addAnimation = (anim) ->
    animations.push(anim)
    handleAnimation()

  removeAnimation = (anim) ->
    id = anim.id

    for animation, idx in animations
      if animation.id == id
        animations.splice idx, 1
        break
  now = (->
    if (window.performance && window.performance.now)
      return ->
        return window.performance.now()
    else
      return ->
        return new Date().getTime()
  )()

  RAF = (->
    window.requestAnimationFrame ||
    window.webkitRequestAnimationFrame ||
    window.mozRequestAnimationFrame ||
    window.oRequestAnimationFrame ||
    window.msRequestAnimationFrame ||
    (callback) -> setTimeout(callback, 1000 / 60)
  )()

  requestAnimFrame = ->
    return RAF.apply(window, arguments)

  runFrames = ->
    for animation in animations
      func = animation.func

      animation.updateFrameObject(now())

      if(func)
        func.call(animation, animation.frame)

  animationLoop = ->
    if(animations.length)
      requestAnimFrame(animationLoop)
      runFrames()
    else
      animRunning = false

  handleAnimation = ->
    if(!animRunning)
      animRunning = true
      animationLoop()

  class Animation

    constructor: (func) ->

      @func = func
      @id = animIdCounter++
      @frame =
        time: 0
        timeDiff: 0
        lastTime: now()

    isRunning: ->
      for animation in animations
        if animation.id == @id
          return true

      return false

    start: ->
      @stop()
      @frame.timeDiff = 0
      @frame.lastTime = now()
      addAnimation(@)

    stop: ->
      removeAnimation(@)

    updateFrameObject: (time) ->
      @frame.timeDiff = time - @frame.lastTime
      @frame.lastTime = time
      @frame.time += @frame.timeDiff
      @frame.frameRate = 1000 / @frame.timeDiff
