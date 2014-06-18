# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Layer'
  '../../validator/LayerProps'
  '../../validator/Graphic'
  '../../handler/Magnify'
  '../widget/Circle'
], (
  Layer
  LayerProps
  Graphic
  Magnify
  Circle
) ->

  'use strict'

  class MagnifyLayer extends Layer

    setup: ->
      @target = @select(@get('magnify-target'))[0]

      @magnify_handle = @select('#magnify-handle')[0]

      @set('offset-x', (@target.canvas.width / 2) - 100)
      @set('offset-y', (@target.canvas.height / 2) - 100)

      @set('w', 200)
      @set('h', 200)

      super()

    capture: (position) ->
      false

    _draw: ->

      @clear()

      context = @canvas.getContext '2d'

      context.beginPath()

      context.save()

      cx = 100 + @get('lineWidth') / 2
      cy = 100 + @get('lineWidth') / 2
      r = 100

      context.arc(cx, cy, r, 0, Math.PI * 2, false)

      context.clip();

      context.rect(cx - r, cy - r, r * 2, r * 2)

      if @get('fillStyle')
        context.fillStyle = @get('fillStyle')
        context.fill()

      target_x = @get('offset-x') + cx
      target_y = @get('offset-y') + cy

      context.drawImage @target.canvas, target_x - r / 2, target_y - r / 2, r, r,
      cx - r, cy - r, 2 * r, 2 * r

      context.restore()

      context.beginPath()

      context.arc(cx, cy, r, 0, 2 * Math.PI, false)
      context.lineWidth = 2
      if @get('strokeStyle')
        context.strokeStyle = @get('strokeStyle')
        context.lineWidth = @get('lineWidth')
        context.stroke();

      @forEach (child) ->
        child.draw context

    event_map: ->
      [
        Magnify
      ]

    @spec:
      type: 'magnify-layer'

      containable: true

      container_type: 'layer'

      description: 'Magnify Layer'

      dependencies: {
        'circle': Circle
      }

      properties: [
        LayerProps
        Graphic
      ]

      components: [{
        type: 'circle'
        attrs:
          'id': 'magnify-handle'
          'cx': 186
          'cy': 186
          'r': 16
          'lineWidth': 6
          'strokeStyle': 'gray'
          'fillStyle': 'black'
          capturable: true
          draggable: true
      }]
