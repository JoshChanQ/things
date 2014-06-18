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
], (
  Stage
  StageProps
  WidgetLayer
  DebugLayer
) ->

  'use strict'

  class WidgetBox extends Stage

    @spec:

      type: 'graph-stage'

      description: 'Graph Drawing Stage'

      containable: true

      container_type: 'stage'

      dependencies:
        'widget-layer': WidgetLayer
        'debug-layer': DebugLayer

      properties: [
        StageProps
      ]

      components: [{
        type: 'widget-layer'
      }, {
        type: 'debug-layer'
      }]
