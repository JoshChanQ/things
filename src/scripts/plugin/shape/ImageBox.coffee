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

  error_image_url = 'data:image/gif;base64,R0lGODlhQABAAJECAACu8FVVVf///wAAACH/C05FVFNDQVBFMi4wAwEAAAAh/wtYTVAgRGF0YVhNUDw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoTWFjaW50b3NoKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpFRTNBNjk3NTA5RDYxMUU0QTVGNEQ5RDg5NURCQUE1MSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpFRTNBNjk3NjA5RDYxMUU0QTVGNEQ5RDg5NURCQUE1MSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkVFM0E2OTczMDlENjExRTRBNUY0RDlEODk1REJBQTUxIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkVFM0E2OTc0MDlENjExRTRBNUY0RDlEODk1REJBQTUxIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+Af/+/fz7+vn49/b19PPy8fDv7u3s6+rp6Ofm5eTj4uHg397d3Nva2djX1tXU09LR0M/OzczLysnIx8bFxMPCwcC/vr28u7q5uLe2tbSzsrGwr66trKuqqainpqWko6KhoJ+enZybmpmYl5aVlJOSkZCPjo2Mi4qJiIeGhYSDgoGAf359fHt6eXh3dnV0c3JxcG9ubWxramloZ2ZlZGNiYWBfXl1cW1pZWFdWVVRTUlFQT05NTEtKSUhHRkVEQ0JBQD8+PTw7Ojk4NzY1NDMyMTAvLi0sKyopKCcmJSQjIiEgHx4dHBsaGRgXFhUUExIREA8ODQwLCgkIBwYFBAMCAQAAIfkEBRQAAgAsAAAAAEAAQAAAAseUj6nL7Q+jnLTai7PevPsPhuJIluaJpurKtm4UBII81zEtxzat6vj+8814KaFtGMwNWUblzZBzElFNIHQZZSqPz513VY0mv72tdJwFm63edLnG1bWXavj5KpS/g0i8VGvHluVWtCbmR1YYeDinp8jXNUi3h9fXOHUSZinp+OL5CRoqOkpaanqKmgpy08k65ZoAiyBbQQvFGos7q3tgO+ELzHvb1Sv8axxMPNxqLJHMrIwE3alabX2Nna29zd3t/Q0eLj5OnlAAACH5BAUUAAIALAkAKgAFAAUAAAIEhI+pWAAh+QQFFAACACwTAA4ABQAhAAACGxRghrua9xpksdLr8Mx8iw+G4kiWZnik6squBQAh+QQFFAACACwaAA4ACAAhAAACKYQMeZvI6ho78EV6ZayI46lZoBd2GakI6sq27gvH8ky3TYrht6Hu614AACH5BAUUAAIALCMADgAJACEAAAIvhGCJl6znGERP1bis1Bk3unlT9pHjBXZpiRrCC8fyTNf2jef6Sy1w7+L1YkBirwAAIfkEBRQAAgAsMQAqAAUABQAAAgSEj6lYADs='
  loading_image_url = 'data:image/gif;base64,R0lGODlhQABAAJECAACu8FVVVf///wAAACH/C05FVFNDQVBFMi4wAwEAAAAh/wtYTVAgRGF0YVhNUDw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoTWFjaW50b3NoKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpFRTNBNjk3NTA5RDYxMUU0QTVGNEQ5RDg5NURCQUE1MSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpFRTNBNjk3NjA5RDYxMUU0QTVGNEQ5RDg5NURCQUE1MSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkVFM0E2OTczMDlENjExRTRBNUY0RDlEODk1REJBQTUxIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkVFM0E2OTc0MDlENjExRTRBNUY0RDlEODk1REJBQTUxIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+Af/+/fz7+vn49/b19PPy8fDv7u3s6+rp6Ofm5eTj4uHg397d3Nva2djX1tXU09LR0M/OzczLysnIx8bFxMPCwcC/vr28u7q5uLe2tbSzsrGwr66trKuqqainpqWko6KhoJ+enZybmpmYl5aVlJOSkZCPjo2Mi4qJiIeGhYSDgoGAf359fHt6eXh3dnV0c3JxcG9ubWxramloZ2ZlZGNiYWBfXl1cW1pZWFdWVVRTUlFQT05NTEtKSUhHRkVEQ0JBQD8+PTw7Ojk4NzY1NDMyMTAvLi0sKyopKCcmJSQjIiEgHx4dHBsaGRgXFhUUExIREA8ODQwLCgkIBwYFBAMCAQAAIfkEBRQAAgAsAAAAAEAAQAAAAseUj6nL7Q+jnLTai7PevPsPhuJIluaJpurKtm4UBII81zEtxzat6vj+8814KaFtGMwNWUblzZBzElFNIHQZZSqPz513VY0mv72tdJwFm63edLnG1bWXavj5KpS/g0i8VGvHluVWtCbmR1YYeDinp8jXNUi3h9fXOHUSZinp+OL5CRoqOkpaanqKmgpy08k65ZoAiyBbQQvFGos7q3tgO+ELzHvb1Sv8axxMPNxqLJHMrIwE3alabX2Nna29zd3t/Q0eLj5OnlAAACH5BAUUAAIALAkAKgAFAAUAAAIEhI+pWAAh+QQFFAACACwTAA4ABQAhAAACGxRghrua9xpksdLr8Mx8iw+G4kiWZnik6squBQAh+QQFFAACACwaAA4ACAAhAAACKYQMeZvI6ho78EV6ZayI46lZoBd2GakI6sq27gvH8ky3TYrht6Hu614AACH5BAUUAAIALCMADgAJACEAAAIvhGCJl6znGERP1bis1Bk3unlT9pHjBXZpiRrCC8fyTNf2jef6Sy1w7+L1YkBirwAAIfkEBRQAAgAsMQAqAAUABQAAAgSEj6lYADs='

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
