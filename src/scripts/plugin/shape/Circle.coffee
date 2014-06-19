# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
  './Shape'
  '../../validator/Graphic'
  '../../validator/Circle'
], (
  _
  Shape
  Graphic
  CircleProps
) ->

  'use strict'

  class Circle extends Shape

    shape: (context) ->
      context.arc(@get('cx'), @get('cy'), @get('r'), 0, 2 * Math.PI, false)

    handles: ->
      ['circle-handle']

    positions: ->
      [['cx', 'cy']]

    dockPoints: ->
      cx = @get('cx')
      cy = @get('cy')
      r = @get('r')

      points = []

      for angle in [0..359] by 45
        points.push [cx + Math.cos(angle * Math.PI / 180) * r, cy - Math.sin(angle * Math.PI / 180) * r]

      points

    @spec:
      type: 'circle'

      containable: false

      description: 'Circle'

      dependencies: {
      }

      properties: [
        CircleProps
        Graphic
      ]
