# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './base/Container'
  './mixin/Dockable'
  './mixin/GroupShapable'
  './validator/ComponentProps'
  './validator/Bound'
  './validator/Graphic'
], (
  Container
  Dockable
  GroupShapable
  ComponentProps
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

    bound: ->
      {
        x: @get('x')
        y: @get('y')
        w: @get('w')
        h: @get('h')
      }

    move: (option, configure) ->
      {delta} = option

      return if _.isEmpty(delta)

      to = {}

      positions = @positions()

      for p in positions
        to[p[0]] = Math.round(@get(p[0]) + delta.x) if delta.x
        to[p[1]] = Math.round(@get(p[1]) + delta.y) if delta.y

      @set to

      return unless configure

      config = {}

      for p in positions
        config[p[0]] = @get(p[0])
        config[p[1]] = @get(p[1])

      @configure config

      console.log @type, @config()

    event_map: null

    @spec:
      type: 'group'

      source: 'core:group.Group'

      containable: true

      container_type: 'group'

      description: 'Group'

      dependencies: {
      }

      properties: [
        ComponentProps
        Bound
        Graphic
        {
          clip:
            type: 'boolean'
            default: true
        }
      ]
