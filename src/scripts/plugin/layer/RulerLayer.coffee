# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../Layer'
  '../shape/Ruler'
  '../../behavior/LayerBehavior'
], (
  Layer
  Ruler
  LayerBehavior
) ->

  "use strict"

  class RulerLayer extends Layer

    onadded: (container) ->

      @target = @select(@get('target'))[0]

      rulers = @select('ruler', @)

      @hori = rulers[0]
      @vert = rulers[1]

      @hori.set
        w: @target.canvas.width
        h: 20
        zeropos: @target.get('offset-x')

      @vert.set
        w: 20
        h: @target.canvas.height
        zeropos: @target.get('offset-y')

      @set
        x: @target.get('x')
        y: @target.get('y')
        w: @target.get('w')
        h: @target.get('h')

    event_map: ->
      [
        LayerBehavior
        {
          '?target':
            '?target':
              'change': @onchange
        }
      ]

    onchange: (target, before, after) ->

      hset = {}
      vset = {}

      hset['zeropos'] = after['offset-x'] if after.hasOwnProperty('offset-x')
      vset['zeropos'] = after['offset-y'] if after.hasOwnProperty('offset-y')
      hset['w'] = after['w'] if after.hasOwnProperty('w')
      vset['h'] = after['h'] if after.hasOwnProperty('h')

      picked = _.pick after, ['x', 'y', 'w', 'h']
      @silentSet picked unless _.isEmpty(picked)

      @hori.silentSet(hset) unless _.isEmpty(hset)
      @vert.silentSet(vset) unless _.isEmpty(vset)

      @draw()

    @spec:
      type: 'ruler-layer'

      source: 'core:layer.RulerLayer'

      containable: true

      container_type: 'layer'

      description: 'Ruler Layer'

      dependencies: {
        'ruler': Ruler
      }

      properties: [
        Layer.spec.properties
        {
          target:
            type: 'string'
        }
      ]

      components: [ {
        type: 'ruler'
        config:
          direction: 'horizontal'
          margin: [20, 0]
          opacity: 0.8
          x: 0
          y: 0
          zeropos: 20
          strokeStyle: 'navy'
          lineWidth: 1
      }, {
        type: 'ruler'
        config:
          direction: 'vertical'
          margin: [20, 0]
          opacity: 0.8
          x: 0
          y: 0
          zeropos: 20
          strokeStyle: 'navy'
          lineWidth: 1
      } ]

