# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../util/Util'
], (
  _
) ->

  'use strict'

  # ComponentFactory class for build Component/Container instance from spec or model
  #
  class ComponentFactory

    # Construct a new animal.
    #
    # @param [ComponentRegistry] component registry from the controller
    # @param [Controller] controller
    #
    constructor: (@componentRegistry, @controller) ->

    dispose: ->
      @componentRegistry = null
      @controller = null

    build: (model, onto_container) ->

      component = @createByModel model

      @setupDescendant component, model.components

      onto_container.add component if onto_container

      component

    create: (type, config) ->

      klass = @componentRegistry.get(type)

      throw new Error('module (' + model.type + ') is not registered yet.') unless klass

      config = {} unless config

      config.id = _.uniqueId() unless config.hasOwnProperty('id')

      component = new klass(type).initialize(config, klass.spec.properties)

      component.setController @controller

      # component lifecycle 'init'
      component.init() if component.init

      # TODO spec이 가진 컴포넌트와 model이 가진 컴포넌트가 혼재한다. 문제없을까 ?
      if klass.spec.components
        for c in klass.spec.components
          @build(c, component)

      component

    createByModel: (model) ->
      (@componentRegistry.register deptype, depspec) for deptype, depspec of model.dependencies if model.dependencies

      @create model.type, model.config

    setupDescendant: (container, components) ->
      klass = @componentRegistry.get(container.type)
      spec = klass.spec

      if components
        for c in components
          @build(c, container)

      container
