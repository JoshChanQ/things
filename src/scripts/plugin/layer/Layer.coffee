# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../base/Container'
  '../../mixin/GroupShapable'
  '../../validator/LayerProps'
  '../../handler/LayerBehavior'
  '../../util/JobPender'
], (
  Container
  GroupShapable
  LayerProps
  LayerBehavior
  JobPender
) ->

  'use strict'

  class Layer extends Container
    # @include GroupShapable

    clearCanvas: ->

      @canvas.getContext('2d').clearRect(0, 0, @canvas.width, @canvas.height)

    _draw: ->
      context = @canvas.getContext '2d'

      context.clearRect(0, 0, @canvas.width, @canvas.height)

      context.save()

      # HERE ; consider get 'x', 'y'
      # console.log @get('x'), @get('y')

      offsetx = @get('offset-x')
      offsety = @get('offset-y')
      context.translate offsetx, offsety

      @forEach (child) ->
        child.draw context

      context.restore()

    draw: ->
      @_draw()
      # @pender.pend()

    shape: (context) ->
      context.rect @get('x'), @get('y'), @get('w'), @get('h')

    capture: (position) ->
      context = @canvas.getContext '2d'

      context.beginPath()

      # HERE ; consider get 'x', 'y'

      translated_position =
        x: position.x - @get('offset-x') - @get('x')
        y: position.y - @get('offset-y') - @get('y')

      @shape context

      if @size() > 0
        for i in [(@size() - 1)..0]
          child = @getAt(i)
          captured = child.capture translated_position, context
          return captured if captured

      return null

    init: (model) ->
      @pender = new JobPender(@, @_draw)

      @html_container = @controller.getStage().html_container

      @canvas = document.createElement('canvas')

      app_attrs = @controller.options.attrs

      x = @get('x') || 0
      y = @get('y') || 0
      w = @get('w') || (app_attrs.w && app_attrs.w - x) || (@html_container.offsetWidth - x)
      h = @get('h') || (app_attrs.h && app_attrs.h - y) || (@html_container.offsetHeight - y)

      @set
        x: x
        y: y
        w: w
        h: h

      if(@get('visible') != false)
        @canvas.style.display = 'block'
      else
        @canvas.style.display = 'none'

      @canvas.style.padding = 0
      @canvas.style.margin = 0
      @canvas.style.border = 0
      @canvas.style.background = 'transparent'
      @canvas.style.position = 'absolute'

      @canvas.style.top = y + 'px'
      @canvas.style.left = x + 'px'
      @canvas.setAttribute 'width', w
      @canvas.setAttribute 'height', h

      @html_container.appendChild(@canvas)

    setup: (model) ->

      @draw()

    event_map: ->
      LayerBehavior

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
