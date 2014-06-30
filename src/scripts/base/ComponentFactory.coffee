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

      component = @createModel model

      onto_container.add component if onto_container

      @setupDescendant component, model.components

      # component lifecycle 'setup'
      component.setup(model) if component.setup

      component

    createModel: (model) ->
      (@componentRegistry.register depspec) for deptype, depspec of model.dependencies if model.dependencies

      klass = @componentRegistry.get(model.type)

      throw new Error('module (' + model.type + ') is not registered yet.') unless klass

      # TODO validation for initialization
      model.attrs = {} unless model.attrs
      model.attrs.id = _.uniqueId() unless model.attrs.hasOwnProperty('id')
      component = new klass(model.type).initialize(model.attrs, klass.spec.properties)

      component.setController @controller

      # component lifecycle 'init'
      component.init(model) if component.init

      component

    setupDescendant: (container, components) ->
      klass = @componentRegistry.get(container.type)
      spec = klass.spec

      # TODO 아래이거 정리해라. ㅠㅠ
      if spec.components
        for c in spec.components
          @build(c, container)

      if components
        for c in components
          @build(c, container)

      container
