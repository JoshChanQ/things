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
  '../../mixin/Shapable'
  '../../validator/Bound'
  '../../validator/Graphic'
], (
  _
  Component
  Dockable
  Serializable
  Shapable
  Bound
  Graphic
) ->

  'use strict'

  class Shape extends Component
    @include Dockable
    @include Serializable
    @include Shapable

    handles: ->
      ['bound-handle']

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

    event_map: ->
      null

    @spec:
      type: 'shape'

      containable: false

      description: 'Abstract Shape'

      dependencies: {
      }

      properties: [
        Bound
        Graphic
      ]
