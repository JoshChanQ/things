# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../Layer'
  '../../behavior/LayerBehavior'
  '../shape/Circle'
], (
  Layer
  LayerBehavior
  Circle
) ->

  'use strict'

  onhandle_dragstart = (e) ->
    @slide_last_position =
      x: e.offsetX
      y: e.offsetY

  onhandle_drag = (e) ->
    delta =
      x: e.offsetX - @slide_last_position.x
      y: e.offsetY - @slide_last_position.y

    @slide_target = @slide_target || @select(@get('target'))[0]

    offset =
      x: @slide_target.get('offset-x')
      y: @slide_target.get('offset-y')

    @slide_target.set
      'offset-x': offset.x + delta.x
      'offset-y': offset.y + delta.y

    @slide_handle.move {delta:delta}

    @slide_last_position =
      x: e.offsetX
      y: e.offsetY

    @draw()

  onhandle_dragend = (e) ->
    @slide_last_position = null
    @slide_handle.set
      cx: @canvas.width / 2 - @get('offset-x')
      cy: @canvas.height / 2 - @get('offset-y')

    @draw()

  EVENT_MAP =
    '(self)':
      '#slide-handle':
        'dragstart': onhandle_dragstart
        'drag': onhandle_drag
        'dragend': onhandle_dragend

  class OutlineLayer extends Layer

    onadded: (container) ->
      @slide_handle = @select('#slide-handle')[0]
      @slide_handle.set
        cx: @canvas.width / 2 - @get('offset-x')
        cy: @canvas.height / 2 - @get('offset-y')

      @draw()

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
        EVENT_MAP
        LayerBehavior
      ]

    @spec:
      type: 'slide-layer'

      source: 'core:layer.SlideLayer'

      containable: true

      container_type: 'layer'

      description: 'Slide Layer'

      dependencies:
        'circle': Circle

      properties: [
        Layer.spec.properties
        {
          target:
            type: 'string'
        }
      ]

      components: [{
        type: 'circle'
        config:
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
