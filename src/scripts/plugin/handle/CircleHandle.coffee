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

  class CircleHandle extends Group

    align: ->
      r = @target.get('r')
      cx = @target.get('cx')
      cy = @target.get('cy')

      theta = Math.random() * 360 * Math.PI / 180

      points = [
        [
          Math.round(cx + Math.cos(theta) * r)
          Math.round(cy + Math.sin(theta) * r)
        ]
      ]

      @forEach (component) ->
        index = component.get('index')
        component.set
          cx: points[index][0]
          cy: points[index][1]

    setup: ->
      @set('clip', false)

      @target = @select(@get('target'))[0]

      @build
        type: 'circle'
        attrs:
          x: 0
          y: 0
          r: 5
          index: 0
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
      type: 'circle-handle'

      containable: false

      description: 'Circle Handle'

      dependencies: {
        'circle': Circle
      }

      properties: [
        {
          target:
            type: 'string'
        }
      ]
