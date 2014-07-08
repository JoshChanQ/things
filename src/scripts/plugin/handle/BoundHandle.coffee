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

  TOP = -1
  MIDDLE = 0
  BOTTOM = 1
  LEFT = -1
  CENTER = 0
  RIGHT = 1

  points =
    [
      [LEFT, TOP]
      [CENTER, TOP]
      [RIGHT, TOP]
      [LEFT, MIDDLE]
      [RIGHT, MIDDLE]
      [LEFT, BOTTOM]
      [CENTER, BOTTOM]
      [RIGHT, BOTTOM]
    ]

  class BoundHandle extends Group

    align: ->
      bound = @target.bound()

      rw = Math.round(bound.w / 2)
      rh = Math.round(bound.h / 2)
      cx = Math.round(bound.x + rw)
      cy = Math.round(bound.y + rh)

      @forEach (component) ->
        index = component.get('index')
        component.set
          x: cx + points[index][0] * rw
          y: cy + points[index][1] * rh

    onadded: (container) ->
      @set('clip', false)

      @target = @select(@get('target'))[0]

      for point, i in points
        @build
          type: 'handle'
          attrs:
            r: 8
            strokeStyle: 'red'
            lineWidth: 2
            capturable: false
            fillStyle: 'black'
            index: i
            draggable: true

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

      target_to =
        w: @target.get('w') + delta.x * points[index][0]
        h: @target.get('h') + delta.y * points[index][1]

      target_to['x'] = @target.get('x') + delta.x if points[index][0] == LEFT
      target_to['y'] = @target.get('y') + delta.y if points[index][1] == TOP

      @target.set target_to

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
      type: 'bound-handle'

      source: 'core:handle.BoundHandle'

      containable: true

      description: 'Bound Handle'

      dependencies: {
        'handle': Handle
      }

      properties: [
        {
          target:
            type: 'string'
        }
      ]
