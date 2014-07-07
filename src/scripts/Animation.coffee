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
    layerHash = {}

    # loop through all animations and execute animation
    #  function.  if the animation object has specified node,
    #  we can add the node to the nodes hash to eliminate
    #  drawing the same node multiple times.  The node property
    #  can be the stage itself or a layer

    needRedraw = false

    for animation in animations
      layers = animation.layers
      func = animation.func

      animation.updateFrameObject(now())

      for layer in layers
        layerHash[layer.get('id')] = layer

      # if animation object has a function, execute it
      if(func)
        # allow anim bypassing drawing
        needRedraw  = (func.call(animation, animation.frame) != false) || needRedraw

    if (needRedraw)
      for id, layer of layerHash
        layer.draw()

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

    constructor: (func, layers) ->

      @func = func
      @setLayers(layers)
      @id = animIdCounter++
      @frame =
        time: 0
        timeDiff: 0
        lastTime: now()

    setLayers: (layers) ->

      lays = []

      if (!layers)
        lays = []
      else if (layers.length > 0)
        lays = layers
      else
        lays = [layers]

      @layers = lays

    getLayers: ->
      @layers

    addLayer: (layer) ->
      layers = @layers

      if (layers)
        len = layers.length

        # don't add the layer if it already exists
        for l in layers
          if l.get('id') == layer.get('id')
            return false
      else
        @layers = []

      @layers.push(layer)

      return true

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
