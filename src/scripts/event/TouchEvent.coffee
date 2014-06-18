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

  trigger = (target, type, origin, offset) ->
    e =
      origin: origin
      type: type
      target: target
      offsetX: offset && offset.x
      offsetY: offset && offset.y

    target.trigger e.type, e

  event_fn = (type) ->
    (target, origin, offset) ->
      trigger target, type, origin, offset

  event_types = [
    'touchstart'
    'touchmove'
    'touchend'
    'dragstart'
    'drag'
    'dragend'
    'longtouch'
  ]

  _.reduce event_types, (result, event_type) ->
    result[event_type] = event_fn(event_type)
    result
  , {}
