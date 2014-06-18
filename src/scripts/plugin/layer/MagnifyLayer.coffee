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

      r = @get('r')
      @set
        'w': 2 * r
        'h': 2 * r
        'offset-x': (@target.canvas.width / 2) - r
        'offset-y': (@target.canvas.height / 2) - r

      @canvas.setAttribute('width', 2 * r)
      @canvas.setAttribute('height', 2 * r)

      @magnify_handle.set
        'cx': r
        'cy': r
        'r': r - 5

      super()

    capture: (position) ->
      false

    _draw: ->

      @clear()

      context = @canvas.getContext '2d'

      context.beginPath()

      context.save()

      r = @get('r')
      ratio = @get('ratio') || 10

      context.arc(r, r, r - 1, 0, Math.PI * 2, false)

      context.clip();

      context.rect(0, 0, r * 2, r * 2)

      if @get('fillStyle')
        context.fillStyle = @get('fillStyle')
        context.fill()

      target_x = @get('offset-x') + r
      target_y = @get('offset-y') + r
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
          'id': 'magnify-handle'
          'cx': 100
          'cy': 100
          'r': 95
          'lineWidth': 10
          'strokeStyle': 'gray'
          capturable: true
          draggable: true
      }]
