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

  ondragstart = (e) ->

    @outline_target = e.target
    @draglast_position =
      x: e.offsetX
      y: e.offsetY

  ondrag = (e) ->
    @offset =
      x: e.offsetX - @draglast_position.x
      y: e.offsetY - @draglast_position.y

    @draw()

  ondragend = (e) ->
    @outline_target = null

    if e.target.move
      e.target.move
        delta: @offset

    @offset = null

    @draw()

  onmouseover = (e) ->
    @outline_target = e.target

    @draw()

  onmouseout = (e) ->
    @outline_target = null

    @draw()

  onchange = (target, before, after) ->
    picked = _.pick after, ['offset-x', 'offset-y']
    @set picked unless _.isEmpty(picked)

  {
    '?outline-target':
      '(all)':
        'mouseover': onmouseover
        'mouseout': onmouseout
        'dragstart': ondragstart
        'drag': ondrag
        'dragend': ondragend
      '?outline-target':
        'change': onchange
  }
