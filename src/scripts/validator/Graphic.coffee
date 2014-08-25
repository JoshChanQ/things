# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  'use strict'

  properties =
    lineWidth:
      type: 'number'
    lineJoin:
      type: 'string'
    lineDash:
      type: 'array'
    lineDashOffset:
      type: 'number'
    fillStyle:
      type: 'string'
    strokeStyle:
      type: 'string'
    alpha:
      type: 'number'
