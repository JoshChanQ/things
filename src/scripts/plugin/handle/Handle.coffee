# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../base/Component'
  '../../handler/HandleHandler'
], (
  Component
  HandleHandler
) ->

  'use strict'

  class Handle extends Component
    _shape: (context) ->
      context.arc(@get('x'), @get('y'), 5, 0, 2 * Math.PI, false)

    draw: (context) ->
      context.beginPath()

      @_shape context

      context.fillStyle = 'red'
      context.fill()

      context.lineWidth = 2
      context.strokeStyle = 'black'
      context.stroke()

    capture: (position, context) ->
      context.beginPath()

      @_shape context

      context.lineWidth = 2

      context.isPointInStroke(position.x, position.y) ||
      context.isPointInPath(position.x, position.y)

    event_map: ->
      [
        HandleHandler
      ]

    @spec:
      type: 'handle'

      containable: false

      description: 'Base Handle'

      dependencies: {}

      properties: [
        {
          x:
            type: 'number'
          y:
            type: 'number'
          index:
            type: 'string'
          target:
            type: 'object'
        }
      ]
