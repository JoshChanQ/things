# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../Shape'
  '../handle/BoundHandle'
  '../handle/RotationHandle'
  '../../validator/Bound'
  '../../validator/Graphic'
], (
  Shape
  BoundHandle
  RotationHandle
  Bound
  Graphic
) ->

  "use strict"

  class ImageBox extends Shape

    capture_shape: (context) ->

      context.rect @get('x'), @get('y'), @image.width, @image.height

    onadded: (container) ->
      @image = new Image()

      self = @
      @image.onload = ->
        self.draw()

      @image.src = @get('src')

    shape: (context) ->
      return unless @image

      if @get('w')
        context.drawImage @image, @get('x'), @get('y'), @get('w'), @get('h')
      else
        context.drawImage @image, @get('x'), @get('y')

    handles: ->
      ['bound-handle', 'rotation-handle']

    event_map: ->
      map =
        '(self)':
          '(self)':
            change: (component, before, after) ->
              return unless after.hasOwnProperty('src')

              @image.src = after['src']

    @spec:
      type: 'image'

      containable: false

      description: 'ImageBox'

      dependencies: {
        'bound-handle': BoundHandle
        'rotation-handle': RotationHandle
      }

      properties: [
        Bound
        Graphic
        {
          src:
            type: 'string'
        }
      ]
