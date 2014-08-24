# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../Layer'
  '../../behavior/LayerBehavior'
], (
  Layer
  LayerBehavior
) ->

  'use strict'

  class WidgetLayer extends Layer

    onadded: (container) ->
      @set('capturable', true)
      @set('draggable', true)

    model: (data, reset) ->
      if reset
        @removeAll()

      return unless data.components

      for widget in data.components
        @build(widget, @)

    event_map: ->
      [
        LayerBehavior
      ]

    @spec:
      type: 'widget-layer'

      source: 'core:layer.WidgetLayer'

      containable: true

      container_type: 'layer'

      description: 'Widgets Layer'

      dependencies: {}

      properties: [
        Layer.spec.properties
      ]
