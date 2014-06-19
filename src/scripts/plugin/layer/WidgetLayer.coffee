# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Layer'
  '../../handler/Redraw'
  '../../validator/LayerProps'
], (
  Layer
  Redraw
  LayerProps
) ->

  'use strict'

  class WidgetLayer extends Layer

    setup: (model) ->
      super()

      widgets = @controller.options.widgets

      for widget in widgets
        @build(widget, @)

    event_map: ->
      [
        Redraw
      ]

    @spec:
      type: 'widget-layer'

      containable: true

      container_type: 'layer'

      description: 'Widgets Layer'

      dependencies: {}

      properties: [
        LayerProps
      ]
