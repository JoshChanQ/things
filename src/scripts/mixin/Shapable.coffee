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

    center: ->
      {
        x: @get('x') + @get('w') / 2
        y: @get('y') + @get('h') / 2
      }

    shape: (context) ->

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

      context.restore()

      if @get('fillStyle')
        context.fillStyle = @get('fillStyle')
        context.fill()

      if @get('strokeStyle')
        context.lineWidth = @get('lineWidth')
        context.strokeStyle = @get('strokeStyle')
        context.stroke()

    capture: (position, context) ->
      context.beginPath()

      rotate = @get('rotate') || 0

      center = @center()

      context.save()

      context.translate(center.x, center.y)
      context.rotate(rotate * Math.PI / 180)
      context.translate(-center.x, -center.y)

      @shape context

      context.restore()

      if @get('strokeStyle')
        context.lineWidth = @get('lineWidth')

      return @ if (!!@get('strokeStyle') && context.isPointInStroke(position.x, position.y)) ||
        (!!@get('fillStyle') && context.isPointInPath(position.x, position.y))

      return null
