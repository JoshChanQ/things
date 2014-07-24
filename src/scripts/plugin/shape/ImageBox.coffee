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
], (
  Shape
  BoundHandle
  RotationHandle
  Bound
) ->

  "use strict"

  error_image_url = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEUAAAD///+l2Z/dAAAAM0lEQVR4nGP4/5/h/1+G/58ZDrAz3D/McH8yw83NDDeNGe4Ug9C9zwz3gVLMDA/A6P9/AFGGFyjOXZtQAAAAAElFTkSuQmCC'
  loading_image_url = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEUAAAD///+l2Z/dAAAAM0lEQVR4nGP4/5/h/1+G/58ZDrAz3D/McH8yw83NDDeNGe4Ug9C9zwz3gVLMDA/A6P9/AFGGFyjOXZtQAAAAAElFTkSuQmCC'

  loading_image = new Image()
  loading_image.src = loading_image_url

  error_image = new Image()
  error_image.src = error_image_url

  class ImageBox extends Shape

    capture_shape: (context) ->

      context.rect @get('x'), @get('y'), @get('w'), @get('h')

    resize: ->
      switch @state
        when 'loaded'
          image = @image
        when 'error'
          image = error_image
        else
          image = loading_image

      @silentSet
        w: unless @config('w') then image.width else @get('w')
        h: unless @config('h') then image.width else @get('g')

    onadded: (container) ->
      @image = new Image()

      @state = 'loading'

      @resize()

      self = @
      @image.onload = ->
        self.state = 'loaded'
        self.resize()
        self.draw()

      @image.onerror = ->
        self.state = 'error'
        self.resize()
        self.draw()

      @image.src = @get('src')

    shape: (context) ->
      switch @state
        when 'loaded'
          image = @image
        when 'error'
          image = error_image
        else
          image = loading_image

      context.drawImage image, @get('x'), @get('y'), @get('w'), @get('h')

    event_map: ->
      map =
        '(self)':
          '(self)':
            change: (component, before, after) ->
              return unless after.hasOwnProperty('src')

              @state = 'loading'
              @image.src = after['src']

    @spec:
      type: 'image'

      source: 'core:shape.ImageBox'

      containable: false

      description: 'ImageBox'

      dependencies: {
        'bound-handle': BoundHandle
        'rotation-handle': RotationHandle
      }

      properties: [
        Shape.spec.properties
        Bound
        {
          src:
            type: 'string'
        }
      ]
