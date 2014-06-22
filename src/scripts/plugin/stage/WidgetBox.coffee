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
  # '../../plugin/layer/HandleLayer'
  '../../plugin/layer/SelectionLayer'
  '../../plugin/layer/MagnifyLayer'
  '../../handler/ContextMenu'
], (
  Stage
  StageProps
  WidgetLayer
  DebugLayer
  OutlineLayer
  # HandleLayer
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
        'outline-layer': OutlineLayer
        # 'handle-layer': HandleLayer
        'selection-layer': SelectionLayer
        'magnify-layer': MagnifyLayer

      properties: [
        StageProps
      ]

      components: [{
        type: 'widget-layer'
        attrs:
          'offset-x': -150
          'offset-y': -150
          'x': 100
          'y': 100
      # }, {
      #   type: 'outline-layer'
      #   attrs:
      #     'outline-target': 'widget-layer'
      #     'slide-target': 'widget-layer'
      }, {
        type: 'selection-layer'
        attrs:
          'target': 'widget-layer'
      # }, {
      #   type: 'handle-layer'
      #   attrs:
      #     'handle-target': 'widget-layer'
      }, {
        type: 'magnify-layer'
        attrs:
          'magnify-target': 'widget-layer'
          'fillStyle': 'white'
          'strokeStyle': 'gray'
          'r': 100
          'ratio': 2
      # }, {
      #   type: 'debug-layer'
      }]
