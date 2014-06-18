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

  {
    '(self)':
      '(all)':
        'added': redraw
        'removed': redraw
        'change': redraw
  }
