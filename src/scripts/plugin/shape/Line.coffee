# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../util/Util'
  '../../Shape'
  '../handle/P2PHandle'
  '../../validator/P2P'
  '../../validator/Graphic'
], (
  _
  Shape
  P2PHandle
  P2P
  Graphic
) ->

  'use strict'

  class Line extends Shape

    center: ->
      {
        x: (@get('x1') + @get('x2')) / 2
        y: (@get('y1') + @get('y2')) / 2
      }

    shape: (context) ->
      context.moveTo @get('x1'), @get('y1')
      context.lineTo @get('x2'), @get('y2')

    handles: ->
      ['p2p-handle']

    positions: ->
      [['x1', 'y1'], ['x2', 'y2']]

    dockPoints: ->
      [
        [@get('x1'), @get('y1')]
        [@get('x2'), @get('y2')]
      ]

    event_map: ->

    @spec:
      type: 'line'

      source: 'core:shape.Line'

      containable: false

      description: 'Direct Line'

      dependencies: {
        'p2p-handle': P2PHandle
      }

      properties: [
        P2P
        Graphic
      ]
