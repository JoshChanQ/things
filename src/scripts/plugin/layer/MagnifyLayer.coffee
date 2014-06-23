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
  '../shape/Circle'
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

      @magnify_edge = @select('#magnify-edge')[0]

      r = @get('r')
      @set
        'w': 2 * r
        'h': 2 * r
        'x': (@target.canvas.width / 2) - r
        'y': (@target.canvas.height / 2) - r

      @canvas.setAttribute('width', 2 * r)
      @canvas.setAttribute('height', 2 * r)

      @magnify_edge.set
        'cx': r
        'cy': r
        'r': r - 5

      super()

    _draw: ->

      @clearCanvas()

      context = @canvas.getContext '2d'

      context.save()

      context.beginPath()

      r = @get('r')
      ratio = @get('ratio')

      context.arc(r, r, r - 1, 0, Math.PI * 2, false)

      context.clip();

      context.rect(0, 0, r * 2, r * 2)

      if @get('fillStyle')
        context.fillStyle = @get('fillStyle')
        context.fill()

      target_x = @get('x') - @target.get('x') + r
      target_y = @get('y') - @target.get('y') + r
      target_w = Math.round(r / ratio)
      target_h = target_w

      context.drawImage @target.canvas, target_x - target_w, target_y - target_h, 2 * target_w, 2 * target_h,
      0, 0, 2 * r, 2 * r

      context.restore()

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
          'id': 'magnify-edge'
          'cx': 100
          'cy': 100
          'r': 95
          'lineWidth': 10
          'strokeStyle': 'black'
          capturable: true
          draggable: true
      }, {
        type: 'circle'
        attrs:
          'id': 'magnify-handle'
          'cx': 180
          'cy': 180
          'r': 16
          'lineWidth': 8
          'strokeStyle': 'black'
          'fillStyle': 'red'
          capturable: true
          draggable: true
      }]
