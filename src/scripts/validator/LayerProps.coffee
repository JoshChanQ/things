# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../util/Util'
  './ComponentProps'
  './Bound'
  './Graphic'
], (
  _
  ComponentProps
  Bound
  Graphic
) ->

  'use strict'

  _.merge {}, ComponentProps, Bound, Graphic,
    'alpha':
      type: 'number'
      default: 100
    'offset-x':
      type: 'number'
      default: 0
    'offset-y':
      type: 'number'
      default: 0
    'resizable':
      type: 'boolean'
