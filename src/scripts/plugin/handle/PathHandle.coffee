# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../util/Util'
  './Handle'
  '../../Group'
], (
  _
  Handle
  Group
) ->

  'use strict'

  class PathHandle extends Group

    align: ->

      points = @target.get('path')

      @forEach (component) ->
        index = component.get('index')
        component.set
          x: points[index][0]
          y: points[index][1]

    onadded: (container) ->
      @set('clip', false)

      @target = @select(@get('target'))[0]

      path = @target.get('path')

      for i in [0..(path.length - 1)]
        @build
          type: 'handle'
          config:
            r: 8
            index: i
            strokeStyle: 'red'
            fillStyle: 'black'
            lineWidth: 2
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

      index = handle.get('index')

      path = _.clone @target.get('path')

      path[index][0] += delta.x
      path[index][1] += delta.y

      @target.set 'path', path

      # @draw()

      @startpos =
        x: e.offsetX
        y: e.offsetY

    ondragend: (e) ->
      @target.configure 'path', @target.get('path')

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
      type: 'path-handle'

      source: 'core:handle.PathHandle'

      containable: true

      description: 'Path Handle'

      dependencies: {
        'handle': Handle
      }

      properties: [
        {
          target:
            type: 'string'
        }
      ]
