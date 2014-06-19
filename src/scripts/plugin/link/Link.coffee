# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../validator/Graphic'
], (
  Graphic
) ->

  'use strict'

  class Link extends Shape

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
        Graphic
        {
          'source':
            type: 'string'
          'source-dock':
            type: 'string'
          'target':
            type: 'string'
          'target-dock':
            type: 'string'
        }
      ]
