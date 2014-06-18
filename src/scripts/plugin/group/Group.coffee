# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../base/Container'
  '../../validator/Bound'
  '../../validator/Graphic'
], (
  Container
  Bound
  Graphic
) ->

  'use strict'

  class Group extends Container
    _shape: (context) ->
      context.rect @get('x'), @get('y'), @get('w'), @get('h')

    draw: (context) ->
      context.beginPath()

      context.save()

      @_shape context

      if @get('fillStyle')
        context.fillStyle = @get('fillStyle')
        context.fill()

      if @get('strokeStyle')
        context.lineWidth = @get('lineWidth')
        context.strokeStyle = @get('strokeStyle')
        context.stroke()

      context.clip();

      @forEach (child) ->
        child.draw context

      context.restore()

    capture: (position, context) ->
      context.beginPath()

      @_shape context

      if @get('strokeStyle')
        context.lineWidth = @get('lineWidth')

      (!!@get('strokeStyle') && context.isPointInStroke(position.x, position.y)) ||
      (!!@get('fillStyle') && context.isPointInPath(position.x, position.y))

    _move_set: ->
      [['x'], ['y']]

    move: (option) ->
      {delta} = option

      return if _.isEmpty(delta)

      to = {}

      if delta.x
        (to[x] = Math.round(@get(x) + delta.x)) for x in @_move_set()[0]
      if delta.y
        (to[y] = Math.round(@get(y) + delta.y)) for y in @_move_set()[1]

      @set to

      @forEach (child) ->
        child.move(option)

    event_map: null

    @spec:
      type: 'group'

      containable: true

      container_type: 'group'

      description: 'Group'

      dependencies: {}

      properties: [
        Bound
        Graphic
      ]
