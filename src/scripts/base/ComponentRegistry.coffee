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

  class ComponentRegistry
    constructor: ->
      @componentSpecs = {}

    dispose: ->
      keys = Object.keys(@componentSpecs)
      @unregister(type) for type in keys

    setRegisterCallback: (callback, context) ->
      @callback_register = if typeof(callback) is 'function' then callback.bind(context) else undefined

    setUnregisterCallback: (callback, context) ->
      @callback_unregister = if typeof(callback) is 'function' then callback.bind(context) else undefined

    # Register application dependent ComponentSpecs recursively
    register: (type, klass) ->
      return if @componentSpecs[type]

      (@register name, depspec) for name, depspec of klass.spec.dependencies if klass.spec.dependencies

      # TODO fix gracefully follow lines
      if klass.spec.properties instanceof Array
        props = {}
        (_.merge props, i) for i in _.flatten(klass.spec.properties)
        klass.spec.properties = props

      @componentSpecs[type] = klass
      @callback_register(klass.spec) if @callback_register

    unregister: (type) ->
      # TODO consider dependencies -
      spec = @componentSpecs[type]
      return if not spec

      delete @componentSpecs[type]
      @callback_unregister(spec) if @callback_unregister

      spec

    forEach: (fn, context) ->
      for own name, spec of @componentSpecs
        fn.call context, name, spec

    list: (filter) ->
      Object.keys(@componentSpecs).map (key) ->
        @componentSpecs[key]
      , this

    get: (type) ->
      spec = @componentSpecs[type]
      return if spec then _.clone(@componentSpecs[type]) else null


