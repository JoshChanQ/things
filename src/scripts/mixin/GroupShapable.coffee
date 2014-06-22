# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  "use strict"

  GroupShapable =

    center: ->
      {
        x: @get('x') + @get('w') / 2
        y: @get('y') + @get('h') / 2
      }

    shape: (context) ->
      # w = @get('w')
      # h = @get('h')
      # context.rect -w / 2, -h / 2, w, h
      context.rect @get('x'), @get('y'), @get('w'), @get('h')

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

      context.clip() if @get('clip')

      context.translate(@get('x'), @get('y'))

      @forEach (child) ->
        child.draw context

      context.restore() # 1'st Restore

    capture: (position, context) ->
      context.beginPath()

      center = @center()
      rotate = (@get('rotate') || 0) * Math.PI / 180

      context.save()

      context.translate(center.x, center.y)
      context.rotate(rotate)
      context.translate(-center.x, -center.y)

      @shape context

      # if @get('strokeStyle')
      context.lineWidth = @get('lineWidth')

      captured = null

      inbound = context.isPointInPath(position.x, position.y) ||
        (!!@get('strokeStyle') && context.isPointInStroke(position.x, position.y))

      if !@get('clip') || inbound
        if @size() > 0

          context.translate(@get('x'), @get('y'))

          for i in [(@size() - 1)..0]
            child = @getAt(i)
            captured = child.capture position, context
            break if captured

      context.restore()

      return captured if captured

      return null if @get('capturable') == false

      return @ if inbound

      return null
