# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../base/Container'
], (
  Container
) ->

  'use strict'

  class Group extends Container

    draw: (context) ->
      context.beginPath()
      context.lineWidth = '6'
      context.strokeStyle = 'blue'

      context.rect @get('x'), @get('y'), @get('w'), @get('h')

      context.stroke()

      @forEach (child) ->
        child.draw context

    capture: (position, context) ->
      context.beginPath()
      context.lineWidth = '6'

      context.rect @get('x'), @get('y'), @get('w'), @get('h')

      return context.isPointInPath(position.x, position.y) || context.isPointInStroke(position.x, position.y)
      # return context.isPointInStroke(position.x, position.y)

    move: (option) ->
      {delta} = option

      return unless delta

      x = @get('x')
      y = @get('y')

      to = {}

      if delta.x
        to.x = x + delta.x

      if delta.y
        to.y = y + delta.y

      @set to

    event_map: null

    @spec:
      type: 'group'

      containable: true

      container_type: 'group'

      description: 'Group'

      dependencies: {}

      properties:
        x:
          type: 'number'
          default: 0
        y:
          type: 'number'
          default: 0
        w:
          type: 'number'
          validators: ['0..100']
          default: 100
        h:
          type: 'number'
          default: 100
        alpha:
          type: 'number'
          default: 100
