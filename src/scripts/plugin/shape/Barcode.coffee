# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../util/Util'
  '../../Shape'
  './ImageBox'
  '../handle/BoundHandle'
  '../handle/RotationHandle'
  '../../validator/Bound'
], (
  _
  Shape
  ImageBox
  BoundHandle
  RotationHandle
  Bound
) ->

  "use strict"

  class Barcode extends ImageBox

    onadded: (container) ->

      @silentSet 'src', @makeurl()

      super container

    makeurl: ->
      # src = document.location.protocol + '://' + document.location.host;
      # if(document.location.port != 80)
      #   src += ':' + document.location.port
      src = 'http://barcode.hatiolab.com:81/?'
      src += 'text=' + window.escape(@get('text'))
      src += '&bcid=' + (@get('symbol') || 'code128')
      src += '&wscale=' + (@get('scale-w') || 2)
      src += '&hscale=' + (@get('scale-h') || 2)
      src += '&rotate=' + (@get('rotation') || 'N')

      if(@get('alttext'))
        src += '&alttext=' + window.escape(@get('alttext'))
      else if(@get('includetext'))
        src += '&alttext=' + window.escape(@get('text'))

      if(@get('barcolor') && @get('barcolor') != '#000000')
        src += '&barcolor=' + window.escape(@get('barcolor'))
      if(@get('backgroundcolor') && @get('backgroundcolor') != '#FFFFFF')
        src += '&backgroundcolor=' + window.escape(@get('backgroundcolor'))

      src

    event_map: ->
      map =
        '(self)':
          '(self)':
            change: (component, before, after) ->
              picked = _.pick after, ['symbol', 'text', 'alttext', 'scale-h', 'scale-w', 'rotation', 'includetext', 'barcolor', 'backgroundcolor']

              unless _.isEmpty(picked)
                @silentSet 'src', @makeurl()
                @image.src = @get('src')

    @spec:
      type: 'barcode'

      source: 'core:shape.Barcode'

      containable: false

      description: 'Barcode'

      dependencies: {
        'bound-handle': BoundHandle
        'rotation-handle': RotationHandle
      }

      properties: [
        Shape.spec.properties
        Bound
        {
          'symbol':
            type: 'string'
          'text':
            type: 'string'
          'alttext':
            type: 'string'
          'scale-h':
            type: 'number'
          'scale-w':
            type: 'number'
          'rotation':
            type: 'sring'
          'includetext':
            type: 'boolean'
          'barcolor':
            type: 'string'
          'backgroundcolor':
            type: 'string'
        }
      ]
