# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
], (
  _
) ->

  "use strict"

  WithProperty =

    set: (key, val)->

      return this if !key

      if arguments.length > 1 && typeof(arguments[0]) is 'string'
        attrs = {}
        attrs[key] = val
        return @set attrs

      @attrs || (@attrs = {})

      attrs = key
      after = {}
      before = {}

      (before[key] = val) for own key, val of @attrs

      _.merge @attrs, attrs

      for own key, val of @attrs
        if val isnt before[key]
          after[key] = val
        else
          delete before[key]

      if Object.keys(after).length isnt 0
        @trigger 'change', this, before, after

      return this

    get: (attr) ->
      return @attrs[attr] if @attrs && @attrs.hasOwnProperty(attr)
      return unless @property_spec
      attr_spec = @property_spec[attr]
      attr_spec.default if attr_spec

    getAll: ->
      if @attrs then _.clone(@attrs) else {}
