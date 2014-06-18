# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
  './Bound'
], (
  _
  Bound
) ->

  'use strict'

  _.merge {}, Bound,
    alpha:
      type: 'number'
      default: 100
