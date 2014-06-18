# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
  '../menu/ContextMenu'
], (
  _
  ContextMenu
) ->

  'use strict'

  oncontextmenu = (e, context) ->
    @debug 'touch', 'xxx'
    ContextMenu.show
      x: e.origin.pageX
      y: e.origin.pageY

  {
    '(root)':
      '(all)':
        'contextmenu': oncontextmenu
        'longtouch': oncontextmenu
  }
