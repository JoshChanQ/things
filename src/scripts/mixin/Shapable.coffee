# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  "use strict"

  Shapable =

    bound: ->
      {
        x: @get('x')
        y: @get('y')
        w: @get('w')
        h: @get('h')
      }

    center: ->
      bound = @bound()
      {
        x: bound.x + bound.w / 2
        y: bound.y + bound.h / 2
      }

    shape: (context) ->

    capture_shape: (context) ->
      @shape(context)

    draw: (context) ->
      return @getContainer().draw() unless context

      context.beginPath()

      rotate = @get('rotate') || 0

      center = @center()

      context.save()

      context.translate(center.x, center.y)
      context.rotate(rotate * Math.PI / 180)
      context.translate(-center.x, -center.y)

      @shape context

      if @get('fillStyle')
        context.fillStyle = @get('fillStyle')
        context.fill()

      if @get('strokeStyle')
        context.lineWidth = @get('lineWidth')
        context.strokeStyle = @get('strokeStyle')
        context.stroke()

      context.restore()

    capture: (position, context) ->
      context.beginPath()

      rotate = @get('rotate') || 0

      center = @center()

      context.save()

      context.translate(center.x, center.y)
      context.rotate(rotate * Math.PI / 180)
      context.translate(-center.x, -center.y)

      @capture_shape context

      if @get('strokeStyle')
        context.lineWidth = @get('lineWidth')

      itsme = (!!@get('strokeStyle') && context.isPointInStroke(position.x, position.y)) ||
        (!!@get('fillStyle') && context.isPointInPath(position.x, position.y))

      context.restore()

      return @ if itsme

      return null
