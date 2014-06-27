# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Layer'
  '../shape/Ruler'
  '../../validator/LayerProps'
], (
  Layer
  Ruler
  LayerProps
) ->

  "use strict"

  class RulerLayer extends Layer

    setup: ->

      @target = @select(@get('target'))[0]

      rulers = @select('ruler', @)

      @hori = rulers[0]
      @vert = rulers[1]

      @hori.set
        w: @target.canvas.width
        h: 20

      @vert.set
        w: 20
        h: @target.canvas.height

      @set
        x: @target.get('x')
        y: @target.get('y')

      super()

    event_map: ->

      '?target':
        '?target':
          'change': @onchange
      '(self)':
        '(self)':
          'change': @onselfchange

    onchange: (target, before, after) ->

      if after.hasOwnProperty('offset-x')
        @hori.set('zeropos', after['offset-x'])
      if after.hasOwnProperty('offset-y')
        @vert.set('zeropos', after['offset-y'])

      picked = _.pick after, ['x', 'y', 'w', 'h']
      @set picked unless _.isEmpty(picked)

      @draw()

    onselfchange: (target, before, after) ->

      @canvas.style.left = after['x'] + 'px' if after.hasOwnProperty('x')
      @canvas.style.top = after['y'] + 'px' if after.hasOwnProperty('y')
      @draw()

    @spec:
      type: 'ruler-layer'

      containable: true

      container_type: 'layer'

      description: 'Ruler Layer'

      dependencies: {
        'ruler': Ruler
      }

      properties: [
        LayerProps
        {
          target:
            type: 'string'
        }
      ]

      components: [
        {
          type: 'ruler'
          attrs:
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
          attrs:
            direction: 'vertical'
            margin: [20, 0]
            opacity: 0.8
            x: 0
            y: 0
            zeropos: 20
            strokeStyle: 'navy'
            lineWidth: 1
        }
      ]

