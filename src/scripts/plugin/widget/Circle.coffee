# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
  './Widget'
  '../../validator/Graphic'
  '../../validator/Circle'
], (
  _
  Widget
  Graphic
  CircleProps
) ->

  'use strict'

  class Circle extends Widget

    _shape: (context) ->
      context.arc(@get('cx'), @get('cy'), @get('r'), 0, 2 * Math.PI, false)

    _move_set: ->
      [['cx'], ['cy']]

    @spec:
      type: 'circle'

      containable: false

      description: 'Circle'

      dependencies: {}

      properties: [
        CircleProps
        Graphic
      ]
