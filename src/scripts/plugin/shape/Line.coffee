# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
  './Shape'
  '../../validator/P2P'
  '../../validator/Graphic'
  '../handle/P2PHandle'
], (
  _
  Shape
  P2P
  Graphic
  P2PHandle
) ->

  'use strict'

  class Line extends Shape

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

      containable: false

      description: 'Direct Line'

      dependencies: {
        'p2p-handle': P2PHandle
      }

      properties: [
        P2P
        Graphic
      ]
