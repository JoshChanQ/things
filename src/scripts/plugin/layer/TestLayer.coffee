# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../Layer'
  '../../behavior/LayerBehavior'
  '../shape/Circle'
], (
  Layer
  LayerBehavior
  Circle
) ->

  'use strict'

  onclick_point = (e) ->
    @slider.set('capturable', false)

  onclick_move = (e) ->
    @slider.set('capturable', true)

  onclick_undo = (e) ->
    console.log('undo click')

  onclick_redo = (e) ->
    console.log('redo click')

  EVENT_MAP =
    '(self)':
      '#point-button':
        'click': onclick_point
      '#move-button':
        'click': onclick_move
      '#undo-button':
        'click': onclick_undo
      '#redo-button':
        'click': onclick_redo

  class TestLayer extends Layer

    onadded: (container) ->
      @slider = @select(@get('slider'))[0]

      @move_button = @select('#point-button')[0]
      @move_button.set
        cx: @canvas.width - 25
        cy: 25

      @move_button = @select('#move-button')[0]
      @move_button.set
        cx: @canvas.width - 25
        cy: 75

      @undo_button = @select('#undo-button')[0]
      @undo_button.set
        cx: @canvas.width - 25
        cy: 125

      @redo_button = @select('#redo-button')[0]
      @redo_button.set
        cx: @canvas.width - 25
        cy: 175

      @draw()

    event_map: ->
      [
        EVENT_MAP
        LayerBehavior
      ]

    @spec:
      type: 'test-layer'

      source: 'core:layer.TestLayer'

      containable: true

      container_type: 'layer'

      description: 'Test Layer'

      dependencies:
        'circle': Circle

      properties: [
        Layer.spec.properties
        {
          'slider':
            type: 'string'
        }
      ]

      components: [{
        type: 'circle'
        config:
          'id': 'point-button'
          'cx': 100
          'cy': 100
          'r': 20
          'lineWidth': 5
          'strokeStyle': 'red'
          'fillStyle': 'black'
          capturable: true
          draggable: true
          alpha: 0.4
      }, {
        type: 'circle'
        config:
          'id': 'move-button'
          'cx': 100
          'cy': 100
          'r': 20
          'lineWidth': 5
          'strokeStyle': 'red'
          'fillStyle': 'black'
          capturable: true
          draggable: true
          alpha: 0.4
      }, {
        type: 'circle'
        config:
          'id': 'undo-button'
          'cx': 100
          'cy': 100
          'r': 20
          'lineWidth': 5
          'strokeStyle': 'red'
          'fillStyle': 'black'
          capturable: true
          draggable: true
          alpha: 0.4
      }, {
        type: 'circle'
        config:
          'id': 'redo-button'
          'cx': 100
          'cy': 100
          'r': 20
          'lineWidth': 5
          'strokeStyle': 'red'
          'fillStyle': 'black'
          capturable: true
          draggable: true
          alpha: 0.4
      }]
