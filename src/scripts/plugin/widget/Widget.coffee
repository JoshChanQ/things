# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
  '../../base/Component'
  '../../validator/Bound'
  '../../validator/Graphic'
], (
  _
  Component
  Bound
  Graphic
) ->

  'use strict'

  class Widget extends Component
    _shape: (context) ->

    draw: (context) ->
      context.beginPath()

      @_shape context

      if @get('fillStyle')
        context.fillStyle = @get('fillStyle')
        context.fill()

      if @get('strokeStyle')
        context.lineWidth = @get('lineWidth')
        context.strokeStyle = @get('strokeStyle')
        context.stroke()

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

    event_map: null

    @spec:
      type: 'widget'

      containable: false

      description: 'Abstract Widget'

      dependencies: {}

      properties: [
        Bound
        Graphic
      ]
