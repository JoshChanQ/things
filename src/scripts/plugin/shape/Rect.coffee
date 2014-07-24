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
], (
  Shape
  BoundHandle
  RotationHandle
  Bound
) ->

  'use strict'

  class Rect extends Shape

    shape: (context) ->
      context.rect @get('x'), @get('y'), @get('w'), @get('h')

    @spec:
      type: 'rect'

      source: 'core:shape.Rect'

      containable: false

      description: 'Rectangle'

      dependencies: {
        'bound-handle': BoundHandle
        'rotation-handle': RotationHandle
      }

      properties: [
        Shape.spec.properties
        Bound
      ]
