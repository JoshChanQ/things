# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Layer'
  '../../validator/LayerProps'
], (
  Layer
  LayerProps
) ->

  'use strict'

  class WidgetLayer extends Layer

    setup: (model) ->
      super()

      widgets = @controller.options.widgets

      for widget in widgets
        @build(widget, @)

    @spec:
      type: 'widget-layer'

      containable: true

      container_type: 'layer'

      description: 'Widgets Layer'

      dependencies: {}

      properties: [
        LayerProps
      ]
