# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../Layer'
  '../../behavior/LayerBehavior'
], (
  Layer
  LayerBehavior
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

  WIDGETS_HANDLER =
    ondragstart: (e) ->

      if e.origin.shiftKey
        @selections = select_add @selections, e.target
      else
        @selections = select @selections, e.target

      @setFocus(@selections[0])

      @draglast_position =
        x: e.offsetX
        y: e.offsetY

    ondrag: (e) ->

      @offset =
        x: e.offsetX - @draglast_position.x
        y: e.offsetY - @draglast_position.y

      @draw()

    ondragend: (e) ->

      # (item.move({delta: @offset})) for item in @selections when item.move

      for item in @selections when item.move
        item.move({delta: @offset}, true)

        # positions = item.positions()

        # config = {}

        # if positions instanceof Array
        #   # Array Type : array of the property names for the points
        #   for p in positions
        #     config[p[0]] = item.get(p[0])
        #     config[p[1]] = item.get(p[1])
        # else
        #   # String Type : property name of the points array possessing current value
        #   path = _.clone @get(positions)
        #   for p in path
        #     config[p[0]] = item.get(p[0])
        #     config[p[1]] = item.get(p[1])

        # item.configure config

      @offset = null

      @draw()

    onclick: (e) ->
      if e.origin.shiftKey
        # Fixme - 쉬프트 키 드래깅 이후에 타겟의 선택이 해제되는 문제.
        @selections = select_toggle @selections, e.target
      else
        @selections = select @selections, e.target

      @setFocus(@selections[0])

      @draw()

  WIDGET_LAYER_HANDLER =
    ondragstart: (e) ->
      @selections = []
      @setFocus()

      @select_last_position =
        x: e.offsetX
        y: e.offsetY

      @selection_box = @build
        type: 'rect'
        config:
          x: @select_last_position.x - @target.get('offset-x')
          y: @select_last_position.y - @target.get('offset-y')
          w: 0
          h: 0
          strokeStyle: 'black'
          lineWidth: 1
          lineJoin: 'round'
          lineDash: [12, 3, 3, 3]
          lineDashOffset: 0

    ondrag: (e) ->
      delta =
        x: e.offsetX - @select_last_position.x
        y: e.offsetY - @select_last_position.y

      # @slide_target = @slide_target || @select(@get('target'))[0]

      # offset =
      #   x: @slide_target.get('offset-x')
      #   y: @slide_target.get('offset-y')

      # @slide_target.set
      #   'offset-x': offset.x + delta.x
      #   'offset-y': offset.y + delta.y

      @select_last_position =
        x: e.offsetX
        y: e.offsetY

      if @selection_box
        @selection_box.set
          w: @select_last_position.x - @selection_box.get('x') - @target.get('offset-x')
          h: @select_last_position.y - @selection_box.get('y') - @target.get('offset-y')

      @draw()

    ondragend: (e) ->
      @select_last_position = null

      if @selection_box
        @selection_box.dispose()
        @selection_box = null

    onclick: (e) ->
      # 클릭된 오브젝트가 타겟레이어 자체인 경우는 셀렉션을 모두 해제한다.
      @selections = []
      @setFocus()

    onchange: (target, before, after) ->
      picked = _.pick after, ['offset-x', 'offset-y', 'x', 'y']
      @set picked unless _.isEmpty(picked)

  onselfchange = (target, before, after) ->
    @canvas.style.left = after['x'] + 'px' if after.hasOwnProperty('x')
    @canvas.style.top = after['y'] + 'px' if after.hasOwnProperty('y')
    @draw()

  EVENT_MAP =
    '?target':
      '(:child)': # (?target:child)가 있으면 좋겠다.
        'click': WIDGETS_HANDLER.onclick
        'tap': WIDGETS_HANDLER.onclick
        'dragstart': WIDGETS_HANDLER.ondragstart
        'drag': WIDGETS_HANDLER.ondrag
        'dragend': WIDGETS_HANDLER.ondragend
      '(:self)':
        'click': WIDGET_LAYER_HANDLER.onclick
        'tap': WIDGET_LAYER_HANDLER.onclick
        'dragstart': WIDGET_LAYER_HANDLER.ondragstart
        'drag': WIDGET_LAYER_HANDLER.ondrag
        'dragend': WIDGET_LAYER_HANDLER.ondragend
        'change': WIDGET_LAYER_HANDLER.onchange
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

      # Selection Box, Handlers ..
      @forEach (child) ->
        child.draw context

      context.restore()

    buildHandles: ->
      for handle in @focus.handles()
        @build
          type: handle
          config:
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

      dependencies: {}

      properties: [
        Layer.spec.properties
        {
          target:
            type: 'string'
        }
      ]
