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

  class Magnifier extends Widget
    setup: ->
      return unless @get('target')

      targets = @select(@get('target'))
      if targets.length > 0
        @target = targets[0]
      else
        @target = null

    draw: (context) ->
      context.beginPath()

      cx = @get('cx')
      cy = @get('cy')
      r = @get('r')
      tcx = @get('target-cx')
      tcy = @get('target-cy')

      ratio = @get('ratio')

      context.save()

      context.arc(cx, cy, r, 0, Math.PI * 2, false)

      context.clip();

      context.rect(cx - r, cy - r, r * 2, r * 2)

      if @get('fillStyle')
        context.fillStyle = @get('fillStyle')
        context.fill()

      if @target
        context.drawImage @target.canvas, tcx - r / ratio, tcy - r / ratio, r, r,
        cx - r, cy - r, 2 * r, 2 * r

      context.restore()

      context.beginPath()

      context.arc(cx, cy, r, 0, 2 * Math.PI, false)
      context.lineWidth = 2
      if @get('strokeStyle')
        context.strokeStyle = @get('strokeStyle')
        context.lineWidth = @get('lineWidth')
        context.stroke();

    _shape: (context) ->
      context.arc(@get('cx'), @get('cy'), @get('r'), 0, 2 * Math.PI, false)

    _move_set: ->
      [['cx'], ['cy']]

    @spec:
      type: 'magnifier'

      containable: false

      description: 'Magnifier'

      dependencies: {}

      properties: [
        CircleProps
        Graphic
        {
          target:
            type: 'string'
          'target-cx':
            type: 'number'
            default: 0
          'target-cy':
            type: 'number'
            default: 0
        }
      ]
