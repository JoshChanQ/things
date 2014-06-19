# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Shape'
  '../../validator/Bound'
  '../../validator/Graphic'
  '../../validator/Font'
], (
  Shape
  Bound
  Graphic
  Font
) ->

  'use strict'

  class Text extends Shape

    _wrap: (context, text, x, y, max_width, line_height) ->
      words = text.split(' ')
      line = ''

      for word, i in words
        testLine = line + word + ' '
        metrics = context.measureText(testLine)
        testWidth = metrics.width
        if testWidth > max_width && i > 0
          context.fillText line, x, y
          line = word + ' '
          y += line_height
        else
          line = testLine

      context.fillText line, x, y

    shape: (context) ->
      @_wrap context, @get('text'), @get('x'), @get('y'), @get('w'), 10

      # draw text
      context.font = @get('font')

    @spec:
      type: 'text'

      containable: false

      description: 'Text Box'

      dependencies: {}

      properties: [
        Bound
        Graphic
        Font
        {
          text:
            type: 'string'
            default: ''
        }
      ]
