# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Shape'
  '../../validator/Bound'
  '../../validator/Graphic'
], (
  Shape
  Bound
  Graphic
) ->

  'use strict'

  class Rect extends Shape

    shape: (context) ->
      context.rect @get('x'), @get('y'), @get('w'), @get('h')

    @spec:
      type: 'rect'

      containable: false

      description: 'Rectangle'

      dependencies: {}

      properties: [
        Bound
        Graphic
      ]
