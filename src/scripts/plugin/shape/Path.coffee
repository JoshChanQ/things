# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../util/Util'
  '../../Shape'
  '../handle/PathHandle'
  '../../validator/PathProps'
], (
  _
  Shape
  PathHandle
  PathProps
) ->

  'use strict'

  class Path extends Shape

    center: ->
      path = @get('path')
      size = path.length

      sum_x = 0
      sum_y = 0

      for i in path
        sum_x += i[0]
        sum_y += i[1]

      {
        x: sum_x / size
        y: sum_y / size
      }

    shape: (context) ->

      path = @get('path')
      size = path.length
      start = path[0]

      context.moveTo start[0], start[1]

      # quadratic curve
      # context.quadraticCurveTo(230, 200, 250, 120);

      # bezier curve
      # context.bezierCurveTo(290, -40, 300, 200, 400, 150);

      for i in [0...size]
        context.lineTo path[i][0], path[i][1]

    handles: ->
      ['path-handle']

    positions: ->
      'path'

    dockPoints: ->
      @get('path')

    event_map: ->

    @spec:
      type: 'path'

      source: 'core:shape.Path'

      containable: false

      description: 'Path'

      dependencies: {
        'path-handle': PathHandle
      }

      properties: [
        Shape.spec.properties
        PathProps
      ]
