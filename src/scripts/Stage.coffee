# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Global'
  './base/Container'
  './validator/StageProps'
  './base/MouseEventEngine'
  './base/TouchEventEngine'
], (
  Global
  Container
  StageProps
  MouseEventEngine
  TouchEventEngine
) ->

  'use strict'

  class Stage extends Container

    draw: ->
      @forEach (layer) ->
        layer.draw

    init: ->
      container = @get('container')
      if container instanceof HTMLElement
        @client_container = container
      else
        @client_container = document.getElementById(@get('container'))

      # clear content inside container
      @client_container.innerHTML = ''

      @html_container = document.createElement('div')
      @html_container.style.position = 'relative'
      @html_container.style.display = 'inline-block'

      w = @get('w')
      h = @get('h')
      @html_container.style.width = if w == undefined || w == null then '100%' else w + 'px'
      @html_container.style.height = if h == undefined || h == null then '100%' else h + 'px'

      @client_container.appendChild(@html_container)

      unless Global.mobile
        @mouseEventEngine = new MouseEventEngine(@)
      @touchEventEngine = new TouchEventEngine(@)

    dispose: ->
      @client_container.removeChild(@html_container)
      @controller.dispose()
      @touchEventEngine.dispose()
      @mouseEventEngine.dispose() if @mouseEventEngine

    capture: (position) ->
      if @size() > 0
        for i in [(@size() - 1)..0]
          child = @getAt(i)
          captured = child.capture position
          return captured if captured

      return @

    position: ->
      return if @html_container.getBoundingClientRect then @html_container.getBoundingClientRect() else { top: 0, left: 0 }

    point: (e) ->
      return @point_pos unless e

      stagePosition = @position()

      x = null
      y = null

      if e.touches != undefined # touch event
        if e.touches.length > 0
          touch = e.touches[0]

          x = touch.clientX - stagePosition.left
          y = touch.clientY - stagePosition.top

      else # mouse event
        div_to_canvas_x = 0
        div_to_canvas_y = 0

        if e.target.tagName == 'CANVAS'
          div_to_canvas_x = e.target.offsetLeft
          div_to_canvas_y = e.target.offsetTop

        if e.offsetX != undefined
          x = e.offsetX + div_to_canvas_x
          y = e.offsetY + div_to_canvas_y
        else if Global.UA.browser == 'mozilla'
          x = e.layerX + div_to_canvas_x
          y = e.layerY + div_to_canvas_y
        else if e.clientX != undefined && stagePosition
          x = e.clientX - stagePosition.left + div_to_canvas_x
          y = e.clientY - stagePosition.top + div_to_canvas_y

      if x != null && y != null
        @point_pos =
          x: x
          y: y

      @point_pos

    register: (type, klass) ->

      @controller.register type, klass

    model: (data) ->

      if data.dependencies
        for type, klass of data.dependencies
          @register type, klass

      @forEach (layer) ->
        layer.model data if layer.model

    change: (changeset) ->

      @controller.change changeset

    @spec:
      type: 'stage'

      containable: true

      container_type: 'stage'

      description: 'Stage'

      dependencies: {}

      properties: [
        StageProps
      ]