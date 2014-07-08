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

  parent_groups_translate = (item, context, container) ->

    parent = item.getContainer()

    parent_groups_translate parent, context, true unless parent.canvas

    return unless container

    rotate = item.get('rotate') || 0

    center = item.center()

    context.translate(center.x, center.y)
    context.rotate(rotate * Math.PI / 180)
    context.translate(-center.x, -center.y)

    context.translate(item.get('x'), item.get('y'))

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

      parent_groups_translate target, context

      center = target.center()
      rotate = target.get('rotate')

      context.translate(center.x, center.y)
      context.rotate(rotate * Math.PI / 180)
      context.translate(-center.x, -center.y)

      context.arc(@get('x'), @get('y'), @get('r'), 0, 2 * Math.PI, false)

      context.restore()

    event_map: ->
      [
        # HandleHandler
      ]

    @spec:
      type: 'handle'

      source: 'core:handle.Handle'

      containable: false

      description: 'Base Handle'

      dependencies: {}

      properties: [
        {
          x:
            type: 'number'
          y:
            type: 'number'
          r:
            type: 'number'
          index:
            type: 'string'
        }
      ]
