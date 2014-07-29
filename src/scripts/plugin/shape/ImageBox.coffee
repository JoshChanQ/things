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

  error_image_url = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoTWFjaW50b3NoKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDoxQjE5RkJCRDBDNTgxMUU0QTVGNEQ5RDg5NURCQUE1MSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDoxQjE5RkJCRTBDNTgxMUU0QTVGNEQ5RDg5NURCQUE1MSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjkwNTBFREMwMEMyOTExRTRBNUY0RDlEODk1REJBQTUxIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjFCMTlGQkJDMEM1ODExRTRBNUY0RDlEODk1REJBQTUxIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+EIm4tgAAAM9JREFUeNrs2jEKwjAUBuBGegoFz6KbzjlnZkfPouA5ohG7lA6CVALv+6dH6JB8fa8U2lRrHSJnMwQPAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgCgZpyKltA0N0FJrfUQ6/Oum77oegfv5uGr9Rpg+j7cRmDqglPLVBnPOq1073/D+cl3E+WW9+w74S1oHfLqgdUBXuZ0Oq9btzIsjEOkhOM4Xok1A8o+QV2EAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIfIUYAC90yH3CRmYMwAAAABJRU5ErkJggg=='
  loading_image_url = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoTWFjaW50b3NoKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo5MDUwRURCRTBDMjkxMUU0QTVGNEQ5RDg5NURCQUE1MSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDo5MDUwRURCRjBDMjkxMUU0QTVGNEQ5RDg5NURCQUE1MSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjkwNTBFREJDMEMyOTExRTRBNUY0RDlEODk1REJBQTUxIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjkwNTBFREJEMEMyOTExRTRBNUY0RDlEODk1REJBQTUxIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+7sUUWAAAAJxJREFUeNrs1rENgDAMBMAYZQoYg9UYg9UYgzkCNKkoaKDA92WUNKeXnWitlcwJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABypHaJiDE1wJWzDXuq+kdMQ0meene4bvHo8TK31+5+lfQN6FvgGoJmQPYG+AgBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADgrzkEGABRjr72QvS8kQAAAABJRU5ErkJggg=='

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

      @set
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

      @image.onerror = ->
        self.state = 'error'
        self.resize()

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
