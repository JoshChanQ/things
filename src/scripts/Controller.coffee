# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'jquery'
  'lodash'
  './base/Component'
  './base/Container'
  './base/ComponentRegistry'
  './base/ComponentSelector'
  './base/ComponentFactory'
  './base/EventEngine'
  './base/MouseEventEngine'
  './base/TouchEventEngine'
  './base/ExportsManager'
  './handler/ControllerHandler'
], (
  $
  _
  Component
  Container
  ComponentRegistry
  ComponentSelector
  ComponentFactory
  EventEngine
  MouseEventEngine
  TouchEventEngine
  ExportsManager
  ControllerHandler
) ->

  'use strict'

  # Mixin Controller dependent method for Component

  Component.include
    setController: (controller) ->
      @controller = controller

    getController: ->
      @controller

    getStage: ->
      @controller.getStage()

    setSpec: (spec) ->
      @spec = spec

    getSpec: ->
      @spec

    build: (model, container) ->
      @controller.build model, container || @

    require: (plugin) ->
      throw new Error('controller not initialized') unless @controller
      @controller.require plugin

    select: (selector, target) ->
      throw new Error('controller not initialized') unless @controller
      @controller.select selector, target

    debug: (category, text) ->
      @require('debug-layer').debug category, text

  Container.include
    isPointInBound: (point) ->
      x1 = @get('x')
      x2 = x1 + @get('w')
      return false if point.x < Math.min(x1, x2) || point.x > Math.max(x1, x2)
      y1 = @get('y')
      y2 = y1 + @get('h')
      return false if point.y < Math.min(y1, y2) || point.y > Math.max(y1, y2)

      true

  class Controller
    constructor: (options) ->
      @options = _.clone options
      @exports = {}

      @exportsManager = new ExportsManager(@)

      @componentRegistry = new ComponentRegistry

      @componentRegistry.setRegisterCallback (spec) ->
        @exportsManager.import(spec.type, spec.exports)
      , @
      @componentRegistry.setUnregisterCallback (spec) ->
        @exportsManager.remove(spec.type)
      , @

      @eventEngine = new EventEngine
      @componentFactory = new ComponentFactory(@componentRegistry, @)

      # setup Stage
      @stage = @componentFactory.createModel options

      @eventEngine.setRoot(@stage)

      # if @stage.event_map
      #   maps = @stage.event_map()
      #   for map in maps
      @eventEngine.add(@stage, @stage.event_map(), @stage) if @stage.event_map

      @eventEngine.add @, ControllerHandler, @

      @componentFactory.setupDescendant @stage

      @mouseEvent = new MouseEventEngine(@stage)
      @touchEvent = new TouchEventEngine(@stage)

    setStage: (stage) ->
      @stage = stage

    getStage: ->
      @stage

    build: (model, onto_container) ->
      @componentFactory.build model, onto_container

    select: (selector, root) ->
      ComponentSelector.select selector, root || @stage

    import: (type, exports, binder) ->
      @exportsManager.import type, exports, binder

    require: (type) ->
      @exportsManager.require type

    dispose: ->
      @componentFactory.dispose()
      @eventEngine.dispose()
      @componentRegistry.dispose()
      @mouseEvent.dispose()
      @touchEvent.dispose()
      @exportsManager.dispose()

  Controller
