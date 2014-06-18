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
      default: 1
    fillStyle:
      type: 'string'
    strokeStyle:
      type: 'string'
      default: 'black'
    alpha:
      type: 'number'
      default: 100
