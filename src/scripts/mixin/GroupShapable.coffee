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

    shape: (context) ->
      context.rect @get('x'), @get('y'), @get('w'), @get('h')

    draw: (context) ->
      return @getContainer().draw() unless context

      context.beginPath()

      context.save()

      @shape context

      if @get('fillStyle')
        context.fillStyle = @get('fillStyle')
        context.fill()

      if @get('strokeStyle')
        context.lineWidth = @get('lineWidth')
        context.strokeStyle = @get('strokeStyle')
        context.stroke()

      context.clip() if @get('clip')

      @forEach (child) ->
        child.draw context

      context.restore()

    capture: (position, context) ->
      context.beginPath()

      @shape context

      if @get('strokeStyle')
        context.lineWidth = @get('lineWidth')

      (!!@get('strokeStyle') && context.isPointInStroke(position.x, position.y)) ||
      (!!@get('fillStyle') && context.isPointInPath(position.x, position.y))
