# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../../util/Util'
  '../../Shape'
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

      context.rect @get('x'), @get('y'), @barcode.width, @barcode.height

    onadded: (container) ->
      @barcode = new Image()

      self = @
      @barcode.onload = ->
        self.draw()

      @barcode.src = @makeurl()

    shape: (context) ->
      return unless @barcode

      try

        if @get('w')
          context.drawImage @barcode, @get('x'), @get('y'), @get('w'), @get('h')
        else
          context.drawImage @barcode, @get('x'), @get('y')

      catch

    bound: ->
      {
        x: @get('x')
        y: @get('y')
        w: @get('w') || @barcode.width
        h: @get('h') || @barcode.height
      }

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
              @barcode.src = @makeurl() unless _.isEmpty(picked)

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
