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

  class Command
    constructor: (params) ->
      @params = _.clone(params)

    execute: ->
    unexecute: ->

  Command
