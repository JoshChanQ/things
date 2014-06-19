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

      theta = @get('theta') || 0 # * Math.PI / 180

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
      @set('theta', 0)

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
      @startpos =
        x: e.offsetX
        y: e.offsetY

    ondrag: (e) ->

      handle = e.target

      delta =
        x: e.offsetX - @startpos.x
        y: e.offsetY - @startpos.y

      newcx = handle.get('cx') + delta.x
      newcy = handle.get('cy') + delta.y

      handle.set
        cx: newcx
        cy: newcy

      dx = newcx - @target.get('cx')
      dy = newcy - @target.get('cy')

      @set
        theta: Math.atan2(dy, dx)

      r = Math.round(Math.sqrt dx * dx + dy * dy)

      @target.set
        r: r

      # @draw()

      @startpos =
        x: e.offsetX
        y: e.offsetY

    ondragend: (e) ->
      # handle = e.target

      # delta =
      #   x: e.offsetX - @startpos.x
      #   y: e.offsetY - @startpos.y

      # newcx = handle.get('cx') + delta.x
      # newcy = handle.get('cy') + delta.y

      # handle.set
      #   cx: newcx
      #   cy: newcy

      # dx = newcx - @target.get('cx')
      # dy = newcy - @target.get('cy')

      # r = Math.round(Math.sqrt dx * dx + dy * dy)

      # @target.set
      #   r: r

      # @target.draw()

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

      containable: true

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
