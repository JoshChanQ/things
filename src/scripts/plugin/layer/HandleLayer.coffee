# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Layer'
  '../../validator/LayerProps'
  '../../handler/Outline'
  '../../handler/Slider'
  '../../handler/Handler'
  '../handle/Handle'
], (
  Layer
  LayerProps
  Outline
  Slider
  Handler
  Handle
) ->

  'use strict'

  class HandleLayer extends Layer

    _draw: ->
      @clearCanvas()

      context = @canvas.getContext '2d'

      offset =
        x: @get('offset-x')
        y: @get('offset-y')

      context.translate offset.x, offset.y

      # context.globalAlpha = 0.5 # Half opacity

      # if @target
        # @target.draw context

      # context.globalAlpha = 1 # Half opacity

      @forEach (child) ->
        child.draw context

      context.translate -offset.x, -offset.y

    buildHandles: ->
      return unless @target.dockPoints
      points = @target.dockPoints()

      for p, index in points
        @build
          type: 'handle'
          attrs:
            x: p[0]
            y: p[1]
            index: index
            target: @target
            draggable: true

    setTarget: (target) ->
      return if @target == target
      @removeAll()

      @target = target
      return unless @target

      @buildHandles()

      @draw()

    event_map: ->
      [
        Handler
      ]

    @spec:
      type: 'handle-layer'

      containable: true

      container_type: 'layer'

      description: 'Handle Layer'

      dependencies: {
        'handle': Handle
      }

      properties: [
        LayerProps
      ]
