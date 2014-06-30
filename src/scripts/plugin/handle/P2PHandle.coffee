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

  class P2PHandle extends Group

    align: ->

      points = [
        [
          @target.get('x1')
          @target.get('y1')
        ]
        [
          @target.get('x2')
          @target.get('y2')
        ]
      ]

      @forEach (component) ->
        index = component.get('index')
        component.set
          x: points[index][0]
          y: points[index][1]

    setup: ->
      @set('clip', false)

      @target = @select(@get('target'))[0]

      for i in [0..1]
        @build
          type: 'handle'
          attrs:
            r: 8
            index: i
            strokeStyle: 'red'
            fillStyle: 'black'
            lineWidth: 2
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

      newcx = handle.get('x') + delta.x
      newcy = handle.get('y') + delta.y

      handle.set
        x: newcx
        y: newcy

      index = handle.get('index')

      switch index
        when 0
          to =
            x1: @target.get('x1') + delta.x
            y1: @target.get('y1') + delta.y
        when 1
          to =
            x2: @target.get('x2') + delta.x
            y2: @target.get('y2') + delta.y

      @target.set to

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
      type: 'p2p-handle'

      containable: true

      description: 'Point-to-Point Handle'

      dependencies: {
        'handle': Handle
      }

      properties: [
        {
          target:
            type: 'string'
        }
      ]
