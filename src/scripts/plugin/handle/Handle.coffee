# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../base/Component'
  '../../mixin/Shapable'
], (
  Component
  Shapable
) ->

  'use strict'

  class Handle extends Component
    @include Shapable

    center: ->
      {
        x: @get('x')
        y: @get('y')
      }

    shape: (context) ->
      target = @getContainer().target

      context.save()
      @_prepare target, context

      center = target.center()
      rotate = target.get('rotate')

      context.translate(center.x, center.y)
      context.rotate(rotate * Math.PI / 180)
      context.translate(-center.x, -center.y)

      context.arc(@get('x'), @get('y'), @get('r'), 0, 2 * Math.PI, false)

      context.restore()
      # context.arc(0, 0, @get('r'), 0, 2 * Math.PI, false)

    _prepare: (item, context, container) ->

      parent = item.getContainer()

      @_prepare parent, context, true unless parent.canvas

      return unless container

      rotate = item.get('rotate') || 0

      center = item.center()

      context.translate(center.x, center.y)
      context.rotate(rotate * Math.PI / 180)
      context.translate(-center.x, -center.y)

      context.translate(item.get('x'), item.get('y'))

    # draw: (context) ->
    #   context.beginPath()

    #   @shape context

    #   context.fillStyle = 'red'
    #   context.fill()

    #   context.lineWidth = 1
    #   context.strokeStyle = 'black'
    #   context.stroke()

    # capture: (position, context) ->
    #   context.beginPath()

    #   @shape context

    #   context.lineWidth = 1

    #   context.isPointInStroke(position.x, position.y) ||
    #   context.isPointInPath(position.x, position.y)

    event_map: ->
      [
        # HandleHandler
      ]

    @spec:
      type: 'handle'

      containable: false

      description: 'Base Handle'

      dependencies: {}

      properties: [
        {
          cx:
            type: 'number'
          cy:
            type: 'number'
          r:
            type: 'number'
          index:
            type: 'string'
        }
      ]
