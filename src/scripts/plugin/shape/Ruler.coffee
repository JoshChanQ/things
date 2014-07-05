# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../Shape'
  '../handle/BoundHandle'
  '../handle/RotationHandle'
  '../../validator/Bound'
  '../../validator/Graphic'
  '../../validator/Font'
], (
  Shape
  BoundHandle
  RotationHandle
  Bound
  Graphic
  Font
) ->

  "use strict"

  # 자동 detect 하도록 개선 ==> http://dpi.lv/
  PIXEL_PER_MM = 3.779527559

  class Ruler extends Shape

    capture_shape: (context) ->

      context.rect @get('x'), @get('y'), @get('w'), @get('h')

    shape: (context) ->

      dimension =
        x: @get('x')
        y: @get('y')
        w: @get('w')
        h: @get('h')

      context.rect dimension.x, dimension.y, dimension.w, dimension.h

      if @get('direction') isnt 'vertical'
        @drawHorizontal context, dimension
      else
        @drawVertical context, dimension

    handles: ->
      ['bound-handle', 'rotation-handle']

    drawHorizontal: (context, dimension) ->
      zeropos = parseInt(@get('zeropos'))
      startX = dimension.x + zeropos
      marginLeft = dimension.x + @get('margin')[0]
      marginRight = dimension.x + dimension.w - @get('margin')[1]

      baseY = dimension.y + dimension.h - 15
      bottomY = dimension.y + dimension.h

      plusWidth = dimension.w - zeropos
      plusCount = Math.ceil(plusWidth / PIXEL_PER_MM)

      for i in [0..(plusCount - 1)]
        x = startX + i * PIXEL_PER_MM

        break if x > marginRight
        continue if x < marginLeft

        if (i % 10 == 0)
          context.moveTo(x, baseY)
          context.lineTo(x, bottomY)
        else if (i % 5 == 0)
          context.moveTo(x, baseY + 8)
          context.lineTo(x, bottomY)
        else
          context.moveTo(x, baseY + 11)
          context.lineTo(x, bottomY)

      minusWidth = zeropos
      minusCount = Math.floor(minusWidth / PIXEL_PER_MM)

      for i in [1..(minusCount - 1)]
        x = startX - i * PIXEL_PER_MM

        break if x < marginLeft
        continue if x > marginRight

        if (i % 10 == 0)
          context.moveTo(x, baseY)
          context.lineTo(x, bottomY)
        else if (i % 5 == 0)
          context.moveTo(x, baseY + 8)
          context.lineTo(x, bottomY)
        else
          context.moveTo(x, baseY + 11)
          context.lineTo(x, bottomY)

      context.textAlign = 'left'
      context.textBaseline = 'bottom'

      for i in [0..(plusCount - 1)] by 10
        x = startX + i * PIXEL_PER_MM
        break if x > marginRight
        continue if x < marginLeft
        context.fillText "#{i / 10}", x + 2, baseY + 10

      for i in [10..(minusCount - 1)] by 10
        x = startX - i * PIXEL_PER_MM
        break if x < marginLeft
        continue if x > marginRight
        context.fillText "-#{i / 10}", x + 2, baseY + 10

    drawVertical: (context, dimension) ->
      zeropos = parseInt(@get('zeropos'))
      startY = dimension.y + zeropos
      marginTop = dimension.y + @get('margin')[0]
      marginBottom = dimension.y + dimension.h - @get('margin')[1]

      baseX = dimension.x + dimension.w - 15
      endX = dimension.x + dimension.w

      plusArea = dimension.h - zeropos
      plusCount = Math.ceil(plusArea / PIXEL_PER_MM)

      for i in [0..(plusCount - 1)]
        y = startY + i * PIXEL_PER_MM

        break if y > marginBottom
        continue if y < marginTop

        if (i % 10 == 0)
          context.moveTo(baseX, y)
          context.lineTo(endX, y)
        else if (i % 5 == 0)
          context.moveTo(baseX + 8, y)
          context.lineTo(endX, y)
        else
          context.moveTo(baseX + 11, y)
          context.lineTo(endX, y)

      minusArea = zeropos
      minusCount = Math.floor(minusArea / PIXEL_PER_MM)

      for i in [1..(minusCount - 1)]
        y = startY - i * PIXEL_PER_MM

        continue if y > marginBottom
        break if y < marginTop

        if (i % 10 == 0)
          context.moveTo(baseX, y)
          context.lineTo(endX, y)
        else if (i % 5 == 0)
          context.moveTo(baseX + 8, y)
          context.lineTo(endX, y)
        else
          context.moveTo(baseX + 11, y)
          context.lineTo(endX, y)

      context.textAlign = 'right'
      context.textBaseline = 'top'

      for i in [0..(plusCount - 1)] by 10
        y = startY + i * PIXEL_PER_MM
        break if y > marginBottom
        continue if y < marginTop
        context.fillText "#{i / 10}", baseX + 10, y + 2

      for i in [10..(minusCount - 1)] by 10
        y = startY - i * PIXEL_PER_MM
        break if y < marginTop
        continue if y > marginBottom
        context.fillText "-#{i / 10}", baseX + 10, y + 2

    @spec:
      type: 'ruler'

      containable: false

      description: 'Ruler'

      dependencies: {
        'bound-handle': BoundHandle
        'rotation-handle': RotationHandle
      }

      properties: [
        Bound
        Graphic
        Font
        {
          'zeropos':
            type: 'number'
            default: 0
          'direction':
            type: 'string'
            default: 'horizontal'
          'margin':
            type: 'array'
            default: [0, 0]
        }
      ]
