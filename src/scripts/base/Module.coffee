# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================
# This class 'Module' is inspired by http://arcturo.github.io/library/coffeescript/03_classes.html

define [
], (
) ->

  'use strict'

  moduleKeywords = ['extended', 'included']

  class Module
    @extend: (obj) ->
      for key, value of obj when key not in moduleKeywords
        console.log key, value
        @[key] = value

      obj.extended?.apply(@)
      @

    @include: (obj) ->
      for key, value of obj when key not in moduleKeywords
        # Assign properties to the prototype
        @::[key] = value

      obj.included?.apply(@)
      @

  Module
