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
  '../../handler/LayerBehavior'
  '../shape/Circle'
], (
  Layer
  LayerProps
  Graphic
  Magnify
  LayerBehavior
  Circle
) ->

  'use strict'

  class MagnifyLayer extends Layer

    setup: (model) ->
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

      super(model)

    _draw: ->

      return unless @target

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

      from_x = target_x - target_w
      from_y = target_y - target_h
      from_w = target_w * 2
      from_h = target_h * 2

      to_x = 0
      to_y = 0
      to_w = 2 * r
      to_h = 2 * r

      if from_x < 0
        to_x += Math.round(-from_x * ratio)
        to_w -= to_x
        from_w -= -from_x
        from_x = 0

      if from_y < 0
        to_y += Math.round(-from_y * ratio)
        to_h -= to_y
        from_h -= -from_y
        from_y = 0

      max_x = @target.canvas.width
      exceed_w = (from_x + from_w) - max_x
      if exceed_w > 0
        from_w -= exceed_w
        to_w -= Math.round(exceed_w * ratio)

      max_y = @target.canvas.height
      exceed_h = (from_y + from_h) - max_y
      if exceed_h > 0
        from_h -= exceed_h
        to_h -= Math.round(exceed_h * ratio)

      context.drawImage @target.canvas, from_x, from_y, from_w, from_h,
      to_x, to_y, to_w, to_h

      context.restore()

      @forEach (child) ->
        child.draw context

    event_map: ->
      [
        Magnify
        LayerBehavior
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
