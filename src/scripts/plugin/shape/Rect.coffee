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

  class Rect extends Shape

    shape: (context) ->
      context.rect @get('x'), @get('y'), @get('w'), @get('h')

    handles: ->
      ['bound-handle', 'rotation-handle']

    @spec:
      type: 'rect'

      containable: false

      description: 'Rectangle'

      dependencies: {
        'bound-handle': BoundHandle
        'rotation-handle': RotationHandle
      }

      properties: [
        Bound
        Graphic
      ]
