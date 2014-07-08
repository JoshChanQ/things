# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../Layer'
  '../../validator/LayerProps'
  '../../behavior/LayerBehavior'
  '../handle/BoundHandle'
  '../handle/CircleHandle'
  '../handle/P2PHandle'
], (
  Layer
  LayerProps
  LayerBehavior
  BoundHandle
  CircleHandle
  P2PHandle
) ->

  'use strict'

  select_toggle = (selections, target) ->
    if _.contains selections, target
      _.pull selections, target
    else
      selections.unshift target

    selections

  select = (selections, target) ->
    return selections if _.contains(selections, target)

    [target]

  select_add = (selections, target) ->
    return selections if _.contains selections, target
    selections.unshift target

    selections

  ondragstart = (e) ->
    if e.origin.shiftKey
      @selections = select_add @selections, e.target
    else
      @selections = select @selections, e.target

    @setFocus(@selections[0])

    @draglast_position =
      x: e.offsetX
      y: e.offsetY

  ondrag = (e) ->

    @offset =
      x: e.offsetX - @draglast_position.x
      y: e.offsetY - @draglast_position.y

    @draw()

  ondragend = (e) ->

    (item.move({delta: @offset})) for item in @selections when item.move

    @offset = null

    @draw()

  onclick = (e) ->

    if e.origin.shiftKey
      # Fixme - 쉬프트 키 드래깅 이후에 타겟의 선택이 해제되는 문제.
      @selections = select_toggle @selections, e.target
    else
      @selections = select @selections, e.target

    @setFocus(@selections[0])

    @draw()

  onchange = (target, before, after) ->
    picked = _.pick after, ['offset-x', 'offset-y', 'x', 'y']
    @set picked unless _.isEmpty(picked)

  onselfchange = (target, before, after) ->
    @canvas.style.left = after['x'] + 'px' if after.hasOwnProperty('x')
    @canvas.style.top = after['y'] + 'px' if after.hasOwnProperty('y')
    @draw()

  EVENT_MAP =
    '?target':
      '(all)':
        'click': onclick
        'tap': onclick
        'dragstart': ondragstart
        'drag': ondrag
        'dragend': ondragend
      '?target':
        'change': onchange
    '(self)':
      '(self)':
        'change': onselfchange


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

    onadded: (container) ->

      @selections = []

      @target = @select(@get('target'))[0]

      position =
        'offset-x': @get('offset-x') || @target.get('offset-x')
        'offset-y': @get('offset-y') || @target.get('offset-y')
        'x': @get('x') || @target.get('x')
        'y': @get('y') || @target.get('y')
        'w': @target.get('w')
        'h': @target.get('h')

      @set position

    _draw: ->

      return unless @selections

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
        EVENT_MAP
        LayerBehavior
      ]

    @spec:
      type: 'selection-layer'

      source: 'core:layer.SelectionLayer'

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
