# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  "use strict"

  Serializable =
    objectify: ->
      # if typeof(@forEach) == 'function'
      #   components = []
      #   @forEach (child) ->
      #     components.push child.objectify()

      content =
        type: @type
        attrs: @attrs

      # content.components = components if components

      # content

    serialize: ->
      JSON.stringify @objectify()
