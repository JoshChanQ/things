# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
  './Widget'
  '../../validator/P2P'
  '../../validator/Graphic'
], (
  _
  Widget
  P2P
  Graphic
) ->

  'use strict'

  class Line extends Widget

    _shape: (context) ->
      context.moveTo @get('x1'), @get('y1')
      context.lineTo @get('x2'), @get('y2')

    _move_set: ->
      [['x1', 'x2'], ['y1', 'y2']]

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
