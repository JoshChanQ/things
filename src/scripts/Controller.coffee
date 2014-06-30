# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './util/Util'
  './Global'
  './base/Component'
  './base/ComponentRegistry'
  './base/ComponentSelector'
  './base/ComponentFactory'
  './base/EventEngine'
  './base/MouseEventEngine'
  './base/TouchEventEngine'
  './base/ExportsManager'
  './command/CommandManager'
  './handler/ControllerHandler'
], (
  _
  Global
  Component
  ComponentRegistry
  ComponentSelector
  ComponentFactory
  EventEngine
  MouseEventEngine
  TouchEventEngine
  ExportsManager
  CommandManager
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

    abs: (v) ->
      rel = @get(v) || 0
      container = @getContainer()
      rel += (container.abs(v) || 0) if container
      rel

    debug: (category, text) ->
      @require('debug-layer').debug category, text

  class Controller
    constructor: (options) ->
      @options = _.clone options
      @exports = {}

      @exportsManager = new ExportsManager(@)

      @commandManager = new CommandManager()

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

      unless Global.mobile
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
      @comandManager.dispose()
      @eventEngine.dispose()
      @componentRegistry.dispose()
      @mouseEvent.dispose() if @mouseEvent
      @touchEvent.dispose()
      @exportsManager.dispose()

  Controller
