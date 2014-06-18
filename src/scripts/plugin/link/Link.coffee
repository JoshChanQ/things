# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Widget'
  '../../validator/P2P'
  '../../validator/Graphic'
], (
  Widget
  P2P
  Graphic
) ->

  'use strict'

  class Link extends Widget

    draw: (context) ->
      context.beginPath()
      context.lineWidth = '6'
      context.strokeStyle = 'green'

      context.moveTo @get('x1'), @get('y1')
      context.lineTo @get('x2'), @get('y2')

      context.stroke()

    capture: (position, context) ->
      context.beginPath()
      context.lineWidth = '6'

      context.moveTo @get('x1'), @get('y1')
      context.lineTo @get('x2'), @get('y2')

      return context.isPointInPath(position.x, position.y) || context.isPointInStroke(position.x, position.y)

    move: (option) ->
      {delta} = option

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

      @set to

    @spec:
      type: 'link'

      containable: false

      description: 'Basic Link'

      dependencies: {}

      properties: [
        P2P
        Graphic
      ]
