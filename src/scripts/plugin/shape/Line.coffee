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
], (
  _
  Shape
  P2P
  Graphic
) ->

  'use strict'

  class Line extends Shape

    _shape: (context) ->
      context.moveTo @get('x1'), @get('y1')
      context.lineTo @get('x2'), @get('y2')

    _points: ->
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

      dependencies: {}

      properties: [
        P2P
        Graphic
      ]
