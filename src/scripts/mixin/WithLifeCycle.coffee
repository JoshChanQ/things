# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  "use strict"

  WithLifeCycle =

    # TODO validation for initialization
    # initialize: (@attrs, @property_spec) ->
    #   # only assign identity if there isn't one (initialize can be called multiple times)
    #   # attrs || (attrs = {})

    #   # merge defaults with supplied options
    #   #
    #   # cloned = Object.create(attrs) : Not sure why @ code does not work
    #   # cloned = {}
    #   # (cloned[key] = val) for own key, val of attrs

    #   # (cloned[key] = val) for own key, val of @defaults when !cloned.hasOwnProperty(key)

    #   # @set(cloned)

    #   @

    initialize: (@configs, @property_spec) ->
      @attrs = {}

      for property, spec of @property_spec
        value = null

        if @configs.hasOwnProperty(property)
          value = @configs[property]
        else if spec.hasOwnProperty('default')
          value = spec.default

        @attrs[property] = value

      @

    dispose: ->
