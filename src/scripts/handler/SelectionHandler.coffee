# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../util/Util'
], (
  _
) ->

  'use strict'

  select_toggle = (selections, target) ->
    if _.contains selections, target
      _.pull selections, target
    else
      selections.unshift target

    selections

  select = (selections, target) ->
    return selections if _.contains(selections, target)

    [target]

  select_add = (selections, target) ->
    return selections if _.contains selections, target
    selections.unshift target

    selections

  ondragstart = (e) ->
    if e.origin.shiftKey
      @selections = select_add @selections, e.target
    else
      @selections = select @selections, e.target

    @setFocus(@selections[0])

    @draglast_position =
      x: e.offsetX
      y: e.offsetY

  ondrag = (e) ->

    @offset =
      x: e.offsetX - @draglast_position.x
      y: e.offsetY - @draglast_position.y

    @draw()

  ondragend = (e) ->

    (item.move({delta: @offset})) for item in @selections when item.move

    @offset = null

    @draw()

  onclick = (e) ->

    if e.origin.shiftKey
      # Fixme - 쉬프트 키 드래깅 이후에 타겟의 선택이 해제되는 문제.
      @selections = select_toggle @selections, e.target
    else
      @selections = select @selections, e.target

    @setFocus(@selections[0])

    @draw()

  onchange = (target, before, after) ->
    picked = _.pick after, ['offset-x', 'offset-y', 'x', 'y']
    @set picked unless _.isEmpty(picked)

  onselfchange = (target, before, after) ->
    @canvas.style.left = after['x'] + 'px' if after.hasOwnProperty('x')
    @canvas.style.top = after['y'] + 'px' if after.hasOwnProperty('y')
    @draw()

  {
    '?target':
      '(all)':
        'click': onclick
        'tap': onclick
        'dragstart': ondragstart
        'drag': ondrag
        'dragend': ondragend
      '?target':
        'change': onchange
    '(self)':
      '(self)':
        'change': onselfchange
  }
