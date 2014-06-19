# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  "use strict"

  Dockable =

    dockType: ->


    dockPoints: ->
      x = @get('x')
      y = @get('y')
      w = @get('w')
      h = @get('h')

      [
        [x, y]
        [x + w, y]
        [x, y + h]
        [x + w, y + h]
      ]
