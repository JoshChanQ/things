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

    move: (option) ->
      {delta} = option

      return unless delta

      x1 = @get('x1')
      y1 = @get('y1')
      x2 = @get('x2')
      y2 = @get('y2')

      to = {}

      if delta.x
        to.x1 = x1 + delta.x
        to.x2 = x2 + delta.x

      if delta.y
        to.y1 = y1 + delta.y
        to.y2 = y2 + delta.y

      @set to unless _.isEmpty(to)

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
