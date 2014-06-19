# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Layer'
  '../../validator/LayerProps'
  '../../handler/Outline'
  '../../handler/Slider'
  '../shape/Circle'
], (
  Layer
  LayerProps
  Outline
  Slider
  Circle
) ->

  'use strict'

  class OutlineLayer extends Layer

    setup: ->
      @slide_handle = @select('#slide-handle')[0]
      @slide_handle.set
        cx: @canvas.width / 2 - @get('offset-x')
        cy: @canvas.height / 2 - @get('offset-y')

      super()

    _draw: ->
      @clearCanvas()

      context = @canvas.getContext '2d'

      offset =
        x: @get('offset-x')
        y: @get('offset-y')

      context.translate offset.x, offset.y

      context.globalAlpha = 0.5 # Half opacity

      if @outline_target
        context.translate @offset.x, @offset.y if @offset
        @outline_target.draw context
        context.translate -@offset.x, -@offset.y if @offset

      context.globalAlpha = 1 # Half opacity

      @forEach (child) ->
        child.draw context

      context.translate -offset.x, -offset.y

    event_map: ->
      [
        Outline
        Slider
      ]

    @spec:
      type: 'outline-layer'

      containable: true

      container_type: 'layer'

      description: 'Outline Layer'

      dependencies:
        'circle': Circle

      properties: [
        LayerProps
      ]

      components: [{
        type: 'circle'
        attrs:
          'id': 'slide-handle'
          'cx': 100
          'cy': 100
          'r': 20
          'lineWidth': 5
          'strokeStyle': 'red'
          'fillStyle': 'black'
          capturable: true
          draggable: true
      }]
