# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  'use strict'

  redraw = (e) ->
    @draw()

  onchange = (target, before, after) ->

    @canvas.style.left = after['x'] + 'px' if after.hasOwnProperty('x')
    @canvas.style.top = after['y'] + 'px' if after.hasOwnProperty('y')
    @canvas.setAttribute 'width', after['w'] if after.hasOwnProperty('w')
    @canvas.setAttribute 'height', after['h'] if after.hasOwnProperty('h')

    @draw()

  {
    '(self)':
      '(all)':
        'added': redraw
        'removed': redraw
        'change': redraw
      '(self)':
        'change': onchange
  }
