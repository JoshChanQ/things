# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Handle'
  '../group/Group'
], (
  Handle
  Group
) ->

  'use strict'

  class CircleHandle extends Group

    align: ->
      r = @target.get('r')
      cx = @target.get('cx')
      cy = @target.get('cy')

      theta = @get('theta') || 0 # * Math.PI / 180

      @handle.set
        x: cx + Math.round(Math.cos(theta) * r)
        y: cy + Math.round(Math.sin(theta) * r)

    setup: ->
      @set('clip', false)
      @set('theta', 0)

      @target = @select(@get('target'))[0]

      @handle = @build
        type: 'handle'
        attrs:
          r: 8
          index: 0
          strokeStyle: 'red'
          fillStyle: 'black'
          lineWidth: 1
          draggable: true

      @align()

    onchange: (e) ->
      @align()
      @draw()

    ondragstart: (e) ->
      @startpos =
        x: e.offsetX
        y: e.offsetY

    ondrag: (e) ->
      handle = e.target

      delta =
        x: e.offsetX - @startpos.x
        y: e.offsetY - @startpos.y

      newcx = handle.get('x') + delta.x
      newcy = handle.get('y') + delta.y

      handle.set
        x: newcx
        y: newcy

      dx = newcx - @target.get('cx')
      dy = newcy - @target.get('cy')

      @set
        theta: Math.atan2(dy, dx)

      r = Math.round(Math.sqrt dx * dx + dy * dy)

      # 주의 : 단순히 회전만 하는 경우 r 의 변화가 없어서 이벤트가 발생하지 않을 수도 있음
      @target.set
        r: r

      # @draw()

      @startpos =
        x: e.offsetX
        y: e.offsetY

    ondragend: (e) ->
      # handle = e.target

      # delta =
      #   x: e.offsetX - @startpos.x
      #   y: e.offsetY - @startpos.y

      # newcx = handle.get('cx') + delta.x
      # newcy = handle.get('cy') + delta.y

      # handle.set
      #   cx: newcx
      #   cy: newcy

      # dx = newcx - @target.get('cx')
      # dy = newcy - @target.get('cy')

      # r = Math.round(Math.sqrt dx * dx + dy * dy)

      # @target.set
      #   r: r

      # @target.draw()

    event_map: ->
      '?target':
        '?target':
          change: @onchange
      '(self)':
        'handle':
          dragstart: @ondragstart
          drag: @ondrag
          dragend: @ondragend

    @spec:
      type: 'circle-handle'

      containable: true

      description: 'Circle Handle'

      dependencies: {
        'handle': Handle
      }

      properties: [
        {
          target:
            type: 'string'
        }
      ]
