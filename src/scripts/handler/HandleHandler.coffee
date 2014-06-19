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

  target =
    onchange: (target, before, after) ->
      console.log 'handle target changed'

      # TODO 여기서부터..

  handle =
    ondragstart: (e) ->
    ondrag: (e) ->
    ondragend: (e) ->

  {
    '?target':
      '?target':
        'change': target.onchange
    '(self)':
      '(self)':
        'dragstart': handle.ondragstart
        'drag': handle.ondrag
        'end': handle.ondragend
  }
