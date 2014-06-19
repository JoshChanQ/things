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
    onmouseover: (e) ->
      @setTarget(e.target)

      @draw()

    onmouseout: (e) ->
      @setTarget(null)

      @draw()

    onchange: (target, before, after) ->
      picked = _.pick after, ['offset-x', 'offset-y']
      @set picked unless _.isEmpty(picked)

  handle =
    onmouseover: (e) ->
    onmouseout: (e) ->

  {
    '?handle-target':
      '(all)':
        'mouseover': target.onmouseover
        'mouseout': target.onmouseout
      '?handle-target':
        'change': target.onchange
    '(self)':
      '(handle)':
        'mouseover': handle.onmouseover
        'mouseout': handle.onmouseout
  }
