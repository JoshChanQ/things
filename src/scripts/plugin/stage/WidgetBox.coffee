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
  '../../plugin/layer/SlideLayer'
  '../../plugin/layer/SelectionLayer'
  '../../plugin/layer/MagnifyLayer'
  '../../handler/ContextMenu'
], (
  Stage
  StageProps
  WidgetLayer
  DebugLayer
  SlideLayer
  SelectionLayer
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
        'slide-layer': SlideLayer
        'selection-layer': SelectionLayer
        'magnify-layer': MagnifyLayer

      properties: [
        StageProps
      ]

      components: [{
        type: 'widget-layer'
        attrs:
          'offset-x': -50
          'offset-y': -50
          'x': 100
          'y': 100
      }, {
        type: 'selection-layer'
        attrs:
          'target': 'widget-layer'
      }, {
        type: 'magnify-layer'
        attrs:
          'magnify-target': 'widget-layer'
          'fillStyle': 'white'
          'strokeStyle': 'gray'
          'r': 100
          'ratio': 2
      }, {
        type: 'slide-layer'
        attrs:
          'slide-target': 'widget-layer'
      }, {
        type: 'debug-layer'
      }]
