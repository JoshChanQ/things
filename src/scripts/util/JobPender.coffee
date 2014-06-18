# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  'use strict'

  TIMEOUT = 1

  class JobPender
    constructor: (@context, @fn) ->
      @flag = false

    pend: ->
      if @flag
        return

      @flag = true

      setTimeout =>
        @pended()
      , TIMEOUT

    pended: ->
      @flag = false
      @fn.call @context

    dispose: =>
      @context = null
      @fn = null
