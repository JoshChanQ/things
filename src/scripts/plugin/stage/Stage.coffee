# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../base/Container'
  '../../validator/StageProps'
], (
  Container
  StageProps
) ->

  'use strict'

  class Stage extends Container

    isPositionInBound: ->
      true

    draw: ->
      @forEach (layer) ->
        layer.draw

    init: ->
      @_container = document.getElementById(@get('container'))

      # clear content inside container
      @_container.innerHTML = ''

      @html_container = document.createElement('div')
      @html_container.style.position = 'relative'
      @html_container.style.display = 'inline-block'

      @_container.appendChild(@html_container)

    dispose: ->
      @_container.removeChild(@html_container)
      @controller.dispose()

    capture: (position) ->
      @

    @spec:
      type: 'stage'

      containable: true

      container_type: 'stage'

      description: 'Abstract Stage'

      dependencies: {}

      properties: [
        StageProps
      ]
