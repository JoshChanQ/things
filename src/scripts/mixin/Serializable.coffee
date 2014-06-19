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
    serialize: ->
      [
        "type: #{this.name}"
        "id: #{this.id}"
        "props: #{JSON.stringify(this.attrs)}"
      ].join(',')

    deserialize: ->
