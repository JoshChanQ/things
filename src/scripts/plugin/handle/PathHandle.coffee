# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../util/Util'
  './Handle'
  './SplitHandle'
  '../../Group'
], (
  _
  Handle
  SplitHandle
  Group
) ->

  'use strict'

  class PathHandle extends Group

    align: ->

      points = @target.get('path')
      points_count = points.length

      @forEach (component) ->
        index = component.get('index')
        if index < points_count
          component.set
            x: points[index][0]
            y: points[index][1]
        else
          first_point_index = index - points_count
          component.set
            x: (points[first_point_index][0] + points[first_point_index + 1][0]) / 2
            y: (points[first_point_index][1] + points[first_point_index + 1][1]) / 2

    buildHandles: ->

      @removeAll()

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

      for i in [0..(path.length - 2)]
        @build
          type: 'split-handle'
          config:
            r: 8
            index: path.length + i
            strokeStyle: 'red'
            fillStyle: 'black'
            lineWidth: 2
            draggable: true

      @align()

    onadded: (container) ->
      @set('clip', false)

      @target = @select(@get('target'))[0]

      @buildHandles()


    onchange: (e) ->
      @align() unless @_split_mode
      @draw()

    path_handle:
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

        newpath = _.clone @target.get('path')

        newpath[index][0] = newcx
        newpath[index][1] = newcy

        @target.set 'path', newpath

        # @draw()

        @startpos =
          x: e.offsetX
          y: e.offsetY

      ondragend: (e) ->
        @target.configure 'path', @target.get('path')

    split_handle:
      ondragstart: (e) ->
        @_split_mode = true

        @startpos =
          x: e.offsetX
          y: e.offsetY

        handle = e.target

        newpath = _.clone @target.get('path')

        index = handle.get('index') - newpath.length

        newpath.splice(index + 1, 0, [e.offsetX, e.offsetY])

        @target.set 'path', newpath

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

        newpath = _.clone @target.get('path')

        index = handle.get('index') - newpath.length + 2

        newpath[index][0] = newcx
        newpath[index][1] = newcy

        @target.set 'path', newpath

        @startpos =
          x: e.offsetX
          y: e.offsetY

      ondragend: (e) ->
        @_split_mode = false
        @target.configure 'path', @target.get('path')

        @buildHandles()

    event_map: ->
      '?target':
        '?target':
          change: @onchange
      '(self)':
        'handle':
          dragstart: @path_handle.ondragstart
          drag: @path_handle.ondrag
          dragend: @path_handle.ondragend
        'split-handle':
          dragstart: @split_handle.ondragstart
          drag: @split_handle.ondrag
          dragend: @split_handle.ondragend

    @spec:
      type: 'path-handle'

      source: 'core:handle.PathHandle'

      containable: true

      description: 'Path Handle'

      dependencies: {
        'handle': Handle
        'split-handle': SplitHandle
      }

      properties: [
        {
          target:
            type: 'string'
        }
      ]
