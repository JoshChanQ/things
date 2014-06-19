# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Layer'
  '../../validator/LayerProps'
  '../../handler/SelectionHandler'
  '../handle/BoundHandle'
  '../handle/CircleHandle'
  '../handle/P2PHandle'
], (
  Layer
  LayerProps
  SelectionHandler
  BoundHandle
  CircleHandle
  P2PHandle
) ->

  'use strict'

  class SelectionLayer extends Layer

    setup: ->

      @selections = []

      super()

    _draw: ->

      @clearCanvas()

      context = @canvas.getContext '2d'

      offset =
        x: @get('offset-x')
        y: @get('offset-y')

      context.translate offset.x, offset.y

      context.globalAlpha = 0.4 # Half opacity

      if @selections.length > 0
        context.translate @offset.x, @offset.y if @offset
        (item.draw context) for item in @selections
        context.translate -@offset.x, -@offset.y if @offset

      context.globalAlpha = 1 # Half opacity

      @forEach (child) ->
        child.draw context

      context.translate -offset.x, -offset.y

    buildHandles: ->
      return unless @focus.dockPoints
      points = @focus.dockPoints()

      # for p, index in points
      for handle in @focus.handles()
        @build
          type: handle
          attrs:
            target: '#' + @focus.get('id')
          # type: 'handle'
          # attrs:
          #   x: p[0]
          #   y: p[1]
          #   index: index
          #   target: '#' + @focus.get('id')
          #   draggable: true

    setFocus: (focus) ->
      return if @focus == focus
      @removeAll()

      @focus = focus
      return unless @focus

      @buildHandles()

      @draw()

    event_map: ->
      [
        SelectionHandler
      ]

    @spec:
      type: 'selection-layer'

      containable: true

      container_type: 'layer'

      description: 'Selection Layer'

      dependencies:
        'bound-handle': BoundHandle
        'circle-handle': CircleHandle
        'p2p-handle': P2PHandle

      properties: [
        LayerProps
        {
          target:
            type: 'string'
        }
      ]
