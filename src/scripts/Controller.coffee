# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './util/Util'
  './Global'
  './Stage'
  './base/Component'
  './base/ComponentRegistry'
  './base/ComponentSelector'
  './base/ComponentFactory'
  './base/EventEngine'
  './base/ExportsManager'
  './command/CommandManager'
  './behavior/ControllerBehavior'
], (
  _
  Global
  Stage
  Component
  ComponentRegistry
  ComponentSelector
  ComponentFactory
  EventEngine
  ExportsManager
  CommandManager
  ControllerBehavior
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

      # create stage
      @componentRegistry.register('stage', Stage)

      @stage = @componentFactory.create 'stage', options

      @eventEngine.setRoot(@stage)

      # set default event handler
      @eventEngine.add @, ControllerBehavior, @

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

    register: (type, klass) ->

      @componentRegistry.register(type, klass)

    apply: (changeset) ->

      for selector, set of changeset
        selections = @select selector
        for component in selections
          component.set set

    execute: (command) ->
      @commandManager.execute(command)

    redo: ->
      @commandManager.redo()

    undo: ->
      @commandManager.undo()

    dispose: ->
      @componentFactory.dispose()
      @commandManager.dispose()
      @eventEngine.dispose()
      @componentRegistry.dispose()
      @exportsManager.dispose()

  Controller
