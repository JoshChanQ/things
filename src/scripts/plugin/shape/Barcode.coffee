# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
  './Shape'
  '../handle/BoundHandle'
  '../handle/RotationHandle'
  '../../validator/Bound'
  '../../validator/Graphic'
], (
  _
  Shape
  BoundHandle
  RotationHandle
  Bound
  Graphic
) ->

  "use strict"

  class Barcode extends Shape

    capture_shape: (context) ->

      context.rect @get('x'), @get('y'), @get('w'), @get('h')

    setup: ->
      @barcode = new Image()

      self = @
      @barcode.onload = ->
        self.draw()

      @barcode.src = @makeurl()

    shape: (context) ->
      return unless @barcode

      try
        context.drawImage @barcode, @get('x'), @get('y'), @get('w'), @get('h')
      catch

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

    handles: ->
      ['bound-handle', 'rotation-handle']

    event_map: ->
      map =
        '(self)':
          '(self)':
            change: (component, before, after) ->
              picked = _.pick after, ['symbol', 'text', 'alttext', 'scale-h', 'scale-w', 'rotation', 'includetext', 'barcolor', 'backgroundcolor']
              @barcode.src = @makeurl() picked unless _.isEmpty(picked)

    @spec:
      type: 'barcode'

      containable: false

      description: 'Barcode'

      dependencies: {
        'bound-handle': BoundHandle
        'rotation-handle': RotationHandle
      }

      properties: [
        Bound
        Graphic
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
