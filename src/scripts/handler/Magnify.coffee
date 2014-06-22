# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
], (
  _
) ->

  'use strict'

  handle =
    ondragstart: (e) ->
      @handle_last_position =
        x: e.offsetX
        y: e.offsetY

    ondrag: (e) ->
      delta =
        x: e.offsetX - @handle_last_position.x
        y: e.offsetY - @handle_last_position.y

      pos_x = @get('x') + delta.x
      pos_y = @get('y') + delta.y

      position =
        'x': pos_x
        'y': pos_y

      # @set(offset)
      @set(position)

      @handle_last_position =
        x: e.offsetX
        y: e.offsetY

      @draw()

    ondragend: (e) ->
      @handle_last_position = null

  edge =
    ondragstart: (e) ->
      @edge_last_position =
        x: e.offsetX
        y: e.offsetY

      @last_ratio = @get('ratio')

    ondrag: (e) ->
      # cx = @get('offset-x') + @get('w') / 2
      # cy = @get('offset-y') + @get('h') / 2

      # x1 = e.offsetX - cx
      # y1 = e.offsetY - cy
      # x2 = @edge_last_position.x - cx
      # y2 = @edge_last_position.y - cy

      delta = e.offsetY - @edge_last_position.y

      ratio = Math.min(Math.max(@last_ratio + delta / 20, 0.5), 4)

      @set('ratio', ratio)

      @draw()

    ondragend: (e) ->
      @edge_last_position = null

  ontargetchange = (target, before, after) ->
    @draw()

  onchange = (target, before, after) ->
    # @canvas.style.left = after['offset-x'] + 'px' if after.hasOwnProperty('offset-x')
    # @canvas.style.top = after['offset-y'] + 'px' if after.hasOwnProperty('offset-y')
    @canvas.style.left = after['x'] + 'px' if after.hasOwnProperty('x')
    @canvas.style.top = after['y'] + 'px' if after.hasOwnProperty('y')

    if after.hasOwnProperty('r')
      @set({w: 2 * after.r, h: 2 * after.r})
      @canvas.setAttribute('width', 2 * after.r)
      @canvas.setAttribute('height', 2 * after.r)

  {
    '?magnify-target':
      '(all)':
        'change': ontargetchange
    '(self)':
      '(self)':
        'change': onchange
      '#magnify-handle':
        'dragstart': handle.ondragstart
        'drag': handle.ondrag
        'dragend': handle.ondragend
      '#magnify-edge':
        'dragstart': edge.ondragstart
        'drag': edge.ondrag
        'dragend': edge.ondragend
  }
