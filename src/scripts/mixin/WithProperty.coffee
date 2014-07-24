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

  "use strict"

  WithProperty =

    config: (attr) ->
      if attr
        @configs[attr]
      else
        @configs

    configure: (key, val) ->
      return @ if !key

      if arguments.length > 1 && typeof(arguments[0]) is 'string'
        configs = {}
        configs[key] = val
        return @configure configs

      @configs || (@configs = {})

      console.log 'configure', key

      configs = key

      attrs = {}

      for own key, val of configs
        spec = @property_spec[key]
        continue unless spec
        @configs[key] = val
        attrs[key] = if spec.transform then spec.transform(val) else val

      @set attrs

      return @

    silentSet: (key, val) ->

      return @ if !key

      if arguments.length > 1 && typeof(arguments[0]) is 'string'
        attrs = {}
        attrs[key] = val
        return @silentSet attrs

      @attrs || (@attrs = {})

      attrs = key

      _.assign @attrs, attrs

      return @

    set: (key, val) ->

      return @ if !key

      if arguments.length > 1 && typeof(arguments[0]) is 'string'
        attrs = {}
        attrs[key] = val
        return @set attrs

      @attrs || (@attrs = {})

      attrs = key
      after = {}

      before = _.clone @attrs

      _.assign @attrs, attrs

      for own key, val of @attrs
        if val isnt before[key]
          after[key] = val
        else
          delete before[key]

      if Object.keys(after).length isnt 0
        @trigger 'change', @, before, after

      return @

    get: (attr) ->
      @attrs[attr]
      # return @attrs[attr] if @attrs && @attrs.hasOwnProperty(attr)
      # return unless @property_spec
      # attr_spec = @property_spec[attr]
      # attr_spec.default if attr_spec

    getAll: ->
      if @attrs then _.clone(@attrs) else {}
