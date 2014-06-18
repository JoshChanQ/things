# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  "use strict"

  class ExportManager
    constructor: (@binder) ->
      @exports = {}

    dispose: ->
      keys = Object.keys(@exports)
      @remove(key) for key in keys

    import: (key, exports, binder) ->
      return unless exports

      _exports = {}

      for k, v of exports
        if v instanceof Function
          _exports[k] = v.bind(binder || @binder)
        else
          _exports[k] = v

      @exports[key] = _exports

    remove: (key) ->
      delete @exports[key]

    require: (key) ->
      @exports[key]

