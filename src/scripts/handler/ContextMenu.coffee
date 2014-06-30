# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../util/Util'
  '../menu/ContextMenu'
], (
  _
  ContextMenu
) ->

  'use strict'

  oncontextmenu = (e, context) ->
    ContextMenu.show
      x: e.origin.pageX
      y: e.origin.pageY

  {
    '(root)':
      '(all)':
        'contextmenu': oncontextmenu
        'longtouch': oncontextmenu
  }
