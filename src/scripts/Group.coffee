# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './base/Container'
  './mixin/Dockable'
  './mixin/GroupShapable'
  './validator/Bound'
  './validator/Graphic'
], (
  Container
  Dockable
  GroupShapable
  Bound
  Graphic
) ->

  'use strict'

  class Group extends Container
    @include Dockable
    @include GroupShapable

    handles: ->
      ['bound-handle', 'rotation-handle']

    positions: ->
      [['x', 'y']]

    move: (option) ->
      {delta} = option

      return if _.isEmpty(delta)

      to = {}

      for p in @positions()
        to[p[0]] = Math.round(@get(p[0]) + delta.x) if delta.x
        to[p[1]] = Math.round(@get(p[1]) + delta.y) if delta.y

      @set to

    event_map: null

    @spec:
      type: 'group'

      containable: true

      container_type: 'group'

      description: 'Group'

      dependencies: {
      }

      properties: [
        Bound
        Graphic
        {
          clip:
            type: 'boolean'
            default: true
        }
      ]
