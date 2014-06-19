# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
  '../../base/Component'
  '../../mixin/Dockable'
  '../../mixin/Serializable'
  '../../validator/Bound'
  '../../validator/Graphic'
], (
  _
  Component
  Dockable
  Serializable
  Bound
  Graphic
) ->

  'use strict'

  class Widget extends Component
    @include Dockable
    @include Serializable

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

    _points: ->
      [['x', 'y']]

    move: (option) ->
      {delta} = option

      return if _.isEmpty(delta)

      to = {}

      for p in @_points()
        to[p[0]] = Math.round(@get(p[0]) + delta.x) if delta.x
        to[p[1]] = Math.round(@get(p[1]) + delta.y) if delta.y

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
