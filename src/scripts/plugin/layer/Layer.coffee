# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../base/Container'
  '../../validator/LayerProps'
  '../../handler/Redraw'
  '../../util/JobPender'
], (
  Container
  LayerProps
  Redraw
  JobPender
) ->

  'use strict'

  class Layer extends Container

    clear: ->

      @canvas.getContext('2d').clearRect(0, 0, @canvas.width, @canvas.height)

    _draw: ->
      context = @canvas.getContext '2d'

      context.clearRect(0, 0, @canvas.width, @canvas.height)

      context.translate @get('offset-x'), @get('offset-y')

      @forEach (child) ->
        child.draw context

      context.translate -@get('offset-x'), -@get('offset-y')

    draw: ->
      @pender.pend()

    capture: ->
      false

    init: (model) ->
      @pender = new JobPender(@, @_draw)

      app_attrs = @controller.options.attrs

      @canvas = document.createElement('canvas')
      @canvas.setAttribute('width', @get('w') || app_attrs.w)
      @canvas.setAttribute('height', @get('h') || app_attrs.h)

      if(@get('visible') != false)
        @canvas.style.display = 'block'
      else
        @canvas.style.display = 'none'

      @canvas.style.padding = 0
      @canvas.style.margin = 0
      @canvas.style.border = 0
      @canvas.style.background = 'transparent'
      @canvas.style.position = 'absolute'
      @canvas.style.top = @get('y') + 'px'
      @canvas.style.left = @get('x') + 'px'

      @html_container = @controller.getStage().html_container
      @html_container.appendChild(@canvas)

    setup: (model) ->
      @draw()

    event_map: ->
      Redraw

    dispose: ->
      @html_container.removeChild(@canvas)
      @controller = null
      @pender.dispose()

    @spec:
      type: 'layer'

      containable: true

      container_type: 'layer'

      description: 'Abstract Layer'

      dependencies: {}

      properties: [
        LayerProps
      ]
