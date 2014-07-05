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
    @draglast_position =
      x: e.offsetX
      y: e.offsetY

  ondrag = (e) ->

    delta =
      x: e.offsetX - @draglast_position.x
      y: e.offsetY - @draglast_position.y

    @draglast_position =
      x: e.offsetX
      y: e.offsetY

    if e.target.move
      e.target.move
        delta: delta

    @draw()

  ondragend = (e) ->

    @draglast_position = null

  {
    '(root)':
      '(all)':
        dragstart: ondragstart
        drag: ondrag
        dragend: ondragend
  }
