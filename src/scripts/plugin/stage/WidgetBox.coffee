# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Stage'
  '../../validator/StageProps'
  '../../plugin/layer/WidgetLayer'
  '../../plugin/layer/DebugLayer'
  '../../plugin/layer/OutlineLayer'
  '../../plugin/layer/MagnifyLayer'
  '../../handler/ContextMenu'
], (
  Stage
  StageProps
  WidgetLayer
  DebugLayer
  OutlineLayer
  MagnifyLayer
  ContextMenu
) ->

  'use strict'

  class WidgetBox extends Stage

    event_map: ->
      [
        ContextMenu
      ]

    @spec:

      type: 'widget-box'

      description: 'Widget Drawing Box'

      containable: true

      container_type: 'stage'

      dependencies:
        'widget-layer': WidgetLayer
        'debug-layer': DebugLayer
        'outline-layer': OutlineLayer
        'magnify-layer': MagnifyLayer

      properties: [
        StageProps
      ]

      components: [{
        type: 'widget-layer'
        attrs: {}
      }, {
        type: 'outline-layer'
        attrs:
          'outline-target': 'widget-layer'
          'slide-target': 'widget-layer'
      }, {
        type: 'magnify-layer'
        attrs:
          'magnify-target': 'widget-layer'
          'fillStyle': 'white'
          'strokeStyle': 'gray'
          'lineWidth': 6
          w: 210
          h: 210
      }, {
        type: 'debug-layer'
      }]
