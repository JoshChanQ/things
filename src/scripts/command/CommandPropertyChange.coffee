# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Command'
], (
  Command
) ->

  "use strict"

  class CommandPropertyChange extends Command

    execute: ->
      for change in @params.changes
        if change.property
          change.component.set change.property, change.after
        else
          change.component.set change.after

    unexecute: ->
      for change in @params.changes
        if change.property
          change.component.set change.property, change.before
        else
          change.component.set change.before
