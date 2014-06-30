# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  'use strict'

  ondragstart = (e) ->
    @slide_last_position =
      x: e.offsetX
      y: e.offsetY

  ondrag = (e) ->
    delta =
      x: e.offsetX - @slide_last_position.x
      y: e.offsetY - @slide_last_position.y

    @slide_target = @slide_target || @select(@get('slide-target'))[0]

    offset =
      x: @slide_target.get('offset-x')
      y: @slide_target.get('offset-y')

    @slide_target.set
      'offset-x': offset.x + delta.x
      'offset-y': offset.y + delta.y

    @slide_handle.move {delta:delta}

    @slide_last_position =
      x: e.offsetX
      y: e.offsetY

    @draw()

  ondragend = (e) ->
    @slide_last_position = null
    @slide_handle.set
      cx: @canvas.width / 2 - @get('offset-x')
      cy: @canvas.height / 2 - @get('offset-y')

    @draw()

  {
    '(self)':
      '#slide-handle':
        'dragstart': ondragstart
        'drag': ondrag
        'dragend': ondragend
  }
