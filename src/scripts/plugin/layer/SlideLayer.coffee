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

    @slide_last_position =
      x: e.offsetX
      y: e.offsetY

  onhandle_dragend = (e) ->
    @slide_last_position = null

  EVENT_MAP =
    '(self)':
      '(self)':
        'dragstart': onhandle_dragstart
        'drag': onhandle_drag
        'dragend': onhandle_dragend
        'click': (e) ->
          console.log 'clickxxx'

  class SlideLayer extends Layer

    onadded: (container) ->
      @set('draggable', true)
      @aaaaaa = 1

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

      dependencies: null

      properties: [
        Layer.spec.properties
        {
          target:
            type: 'string'
        }
      ]
