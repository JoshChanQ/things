# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
  '../group/Group'
  '../shape/Circle'
], (
  _
  Group
  Circle
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
      [TOP, LEFT]
      [TOP, CENTER]
      [TOP, RIGHT]
      [MIDDLE, LEFT]
      [MIDDLE, RIGHT]
      [BOTTOM, LEFT]
      [BOTTOM, CENTER]
      [BOTTOM, RIGHT]
    ]

  class BoundHandle extends Group

    align: ->
      rw = Math.round(@target.get('w') / 2)
      rh = Math.round(@target.get('h') / 2)
      cx = Math.round(@target.get('x') + rw)
      cy = Math.round(@target.get('y') + rh)

      @forEach (component) ->
        index = component.get('index')
        component.set
          cx: cx + points[index][0] * rw
          cy: cy + points[index][1] * rh

    setup: ->
      @set('clip', false)

      @target = @select(@get('target'))[0]

      for point, i in points
        @build
          type: 'circle'
          attrs:
            x: 0
            y: 0
            r: 5
            index: i
            fillStyle: 'white'
            strokeStyle: 'black'
            lineWidth: 1
            draggable: true

      @align()

    onchange: (e) ->
      @align()
      @draw()

    ondragstart: (e) ->

    ondrag: (e) ->

    ondragend: (e) ->

    event_map: ->
      '?target':
        '?target':
          change: @onchange
      '(self)':
        'circle':
          dragstart: @ondragstart
          drag: @ondrag
          dragend: @ondragend

    @spec:
      type: 'bound-handle'

      containable: true

      description: 'Bound Handle'

      dependencies: {
        'circle': Circle
      }

      properties: [
        {
          target:
            type: 'string'
        }
      ]
