# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Handle'
  '../../mixin/Shapable'
  '../../validator/ComponentProps'
  '../../validator/Graphic'
], (
  Handle
  Shapable
  ComponentProps
  Graphic
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

  class SplitHandle extends Handle
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

      radius = @get('r')
      context.rect(@get('x') - radius, @get('y') - radius, 2 * radius, 2 * radius)

      context.restore()

    event_map: ->
      [
        # HandleHandler
      ]

    @spec:
      type: 'handle'

      source: 'core:handle.SplitHandle'

      containable: false

      description: 'Path Splitter Handle'

      dependencies: {}

      properties: [
        ComponentProps
        Graphic
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
