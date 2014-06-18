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

  ondragstart = (e) ->
    @handle_last_position =
      x: e.offsetX
      y: e.offsetY

  ondrag = (e) ->
    delta =
      x: e.offsetX - @handle_last_position.x
      y: e.offsetY - @handle_last_position.y

    offset_x = @get('offset-x') + delta.x
    offset_y = @get('offset-y') + delta.y

    offset =
      'offset-x': offset_x
      'offset-y': offset_y

    @set(offset)

    @handle_last_position =
      x: e.offsetX
      y: e.offsetY

    @draw()

  ondragend = (e) ->
    @handle_last_position = null

  ontargetchange = (target, before, after) ->
    @draw()

  onchange = (target, before, after) ->
    @canvas.style.left = after['offset-x'] + 'px' if after.hasOwnProperty('offset-x')
    @canvas.style.top = after['offset-y'] + 'px' if after.hasOwnProperty('offset-y')

  {
    '?magnify-target':
      '(all)':
        'change': ontargetchange
    '(self)':
      '(self)':
        'change': onchange
      '#magnify-handle':
        'dragstart': ondragstart
        'drag': ondrag
        'dragend': ondragend
  }
