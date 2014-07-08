# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Handle'
  '../../Group'
], (
  Handle
  Group
) ->

  'use strict'

  class RotationHandle extends Group

    align: ->
      bound = @target.bound()

      rw = Math.round(bound.w / 2)
      rh = Math.round(bound.h / 2)
      cx = Math.round(bound.x + bound.w / 2)
      cy = Math.round(bound.y - 20)

      @handle.set
        x: cx
        y: cy

    onadded: (container) ->
      @set('clip', false)

      @target = @select(@get('target'))[0]

      @handle = @build
        type: 'handle'
        attrs:
          r: 8
          draggable: true
          strokeStyle: 'red'
          fillStyle: 'black'
          lineWidth: 1

      @align()

    onchange: (e) ->
      @align()
      @draw()

    ondragstart: (e) ->
      @startpos =
        x: e.offsetX
        y: e.offsetY

    ondrag: (e) ->
      handle = e.target

      delta =
        x: e.offsetX - @startpos.x
        y: e.offsetY - @startpos.y

      index = handle.get('index')

      bound = @target.bound()

      ox = Math.round(bound.x + bound.w / 2)
      oy = Math.round(bound.y + bound.h / 2)

      theta = Math.atan2(e.offsetY - oy, e.offsetX - ox)
      theta -= Math.atan2(@startpos.y - oy, @startpos.x - ox)

      rotate = @target.get('rotate') || 0
      @target.set
        rotate: rotate + (theta * 180 / Math.PI)

      # @draw()

      @startpos =
        x: e.offsetX
        y: e.offsetY

    ondragend: (e) ->

    event_map: ->
      '?target':
        '?target':
          change: @onchange
      '(self)':
        'handle':
          dragstart: @ondragstart
          drag: @ondrag
          dragend: @ondragend

    @spec:
      type: 'rotation-handle'

      source: 'core:handle.RotationHandle'

      containable: true

      description: 'Rotation Handle'

      dependencies: {
        'handle': Handle
      }

      properties: [
        {
          target:
            type: 'string'
        }
      ]
