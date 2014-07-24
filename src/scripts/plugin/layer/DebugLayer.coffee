# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../Layer'
  '../shape/Text'
  '../../util/PrettyPrint'
], (
  Layer
  Text
  pp
) ->

  'use strict'

  exports =
    debug: (category, content) ->

      get_debug_layer = =>
        @debug_layer || (@debug_layer = @select('debug-layer')[0] unless @debug_layer)

      get_debug_text = =>
        @debug_text || (@debug_text = @select('text', get_debug_layer())[0] unless @debug_text)

      get_debug_text().set('text', category + ':' + pp(content))
      get_debug_layer().draw()

  class DebugLayer extends Layer

    @spec:
      type: 'debug-layer'

      source: 'core:layer.DebugLayer'

      containable: true

      container_type: 'layer'

      description: 'Debug Layer'

      dependencies:
        'text': Text

      properties: [
        Layer.spec.properties
      ]

      components: [{
        type: 'text'
        name: 'debug-text'
        config:
          text: ''
          x: 0
          y: 20
          w: 300
          h: 300
          capturable: false
      }]

      exports: exports
