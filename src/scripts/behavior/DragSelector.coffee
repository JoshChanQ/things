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

    @selector_start =
      x: e.offsetX
      y: e.offsetY

  ondrag = (e) ->

    if e.target.move
      e.target.move
        delta:
          x: e.deltaX
          y: e.deltaY

    @draw()

  ondragend = (e) ->

  {
    '(root)':
      '(all)':
        dragstart: ondragstart
        drag: ondrag
        dragend: ondragend
  }
