# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Handle'
  '../group/Group'
], (
  Handle
  Group
) ->

  'use strict'

  class RotationHandle extends Group

    align: ->
      x = @target.get('x')
      y = @target.get('y')
      w = @target.get('w')
      h = @target.get('h')

      rw = Math.round(w / 2)
      rh = Math.round(h / 2)
      cx = Math.round(x + w / 2)
      cy = Math.round(y - 20)

      @handle.set
        x: cx
        y: cy

    setup: ->
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

      x = @target.get('x')
      y = @target.get('y')
      w = @target.get('w')
      h = @target.get('h')

      ox = Math.round(x + w / 2)
      oy = Math.round(y + h / 2)

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
