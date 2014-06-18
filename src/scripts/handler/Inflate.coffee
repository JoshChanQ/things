# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  'use strict'

  onmouseover = (e) ->
    # @require('debug-layer').debug 'MouseOver', '--'

  onmouseout = (e) ->
    # @require('debug-layer').debug 'MouseOut', '--'

  {
    '(self)':
      '(all)':
        'mouseover': onmouseover
        'mouseout': onmouseout
  }
