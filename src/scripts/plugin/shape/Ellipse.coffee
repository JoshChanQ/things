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
], (
  Shape
  BoundHandle
  RotationHandle
  Bound
  Graphic
) ->

  'use strict'

  class Ellipse extends Shape

    shape: (context) ->
      x = @get('x')
      y = @get('y')
      w = @get('w')
      h = @get('h')

      cx = x + w / 2
      cy = y + h / 2

      r = w / 2

      context.save()

      context.scale(1, h / w)
      context.arc(cx, cy * w / h, r, 0, 2 * Math.PI, false)

      context.restore()

    handles: ->
      ['bound-handle', 'rotation-handle']

    @spec:
      type: 'ellipse'

      containable: false

      description: 'Ellipse'

      dependencies: {
        'bound-handle': BoundHandle
        'rotation-handle': RotationHandle
      }

      properties: [
        Bound
        Graphic
      ]
