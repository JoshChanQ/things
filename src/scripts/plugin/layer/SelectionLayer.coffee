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

  parent_groups_translate = (item, context, container) ->

    parent = item.getContainer()

    parent_groups_translate parent, context, true unless parent.canvas

    return unless container

    rotate = item.get('rotate') || 0

    center = item.center()

    context.translate(center.x, center.y)
    context.rotate(rotate * Math.PI / 180)
    context.translate(-center.x, -center.y)

    context.translate(item.get('x'), item.get('y'))

  class SelectionLayer extends Layer

    capture: (position) ->
      context = @canvas.getContext '2d'

      context.beginPath()

      translated_position =
        x: position.x - @get('offset-x') - @get('x')
        y: position.y - @get('offset-y') - @get('y')

      @shape context

      if @size() > 0
        for i in [(@size() - 1)..0]
          child = @getAt(i)
          captured = child.capture translated_position, context
          return captured if captured

      return null


    setup: ->

      @selections = []

      @target = @select(@get('target'))[0]

      position =
        'offset-x': @get('offset-x') || @target.get('offset-x')
        'offset-y': @get('offset-y') || @target.get('offset-y')
        'x': @get('x') || @target.get('x')
        'y': @get('y') || @target.get('y')

      @set position

      super()

    _draw: ->

      @clearCanvas()

      context = @canvas.getContext '2d'

      context.save()

      context.translate @get('offset-x'), @get('offset-y') # canvas offset

      context.globalAlpha = 0.4 # Half opacity

      if @selections.length > 0
        context.save()

        context.translate @offset.x, @offset.y if @offset # dragging offset
        for item in @selections
          context.save()
          parent_groups_translate item, context
          item.draw context
          context.restore()

        context.restore()

      context.globalAlpha = 1 # Half opacity

      if @focus
        @forEach (child) ->
          child.draw context

      context.restore()

    buildHandles: ->

      for handle in @focus.handles()
        @build
          type: handle
          attrs:
            target: '#' + @focus.get('id')

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
