# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  'lodash'
], (
  _
) ->

  'use strict'

  # meta = {
  #   ctrlKey: true
  #   shiftKey: true
  #   altKey: true
  #   metaKey: true
  #   buttons: true
  #   clientX: true # long (int) - The X coordinate of the mouse pointer in local (DOM content) coordinates relative to the viewport in CSS pixels.
  #   clientY: true # long (int) - The Y coordinate of the mouse pointer in local (DOM content) coordinates relative to the viewport in CSS pixels.
  #   screenX: true # long (int) - The X coordinate of the mouse pointer in global (screen) coorninates relative to the screen in device pixels.
  #   screenY: true # long (int) - The Y coordinate of the mouse pointer in global (screen) coorninates relative to the screen in device pixels.
  #   pageX: true # long (int) - The X coordinated of the mouse pointer in local (DOM content) coordinates relative to the <html> element in CSS pixels.
  #   pageY: true # long (int) - The X coordinated of the mouse pointer in local (DOM content) coordinates relative to the <html> element in CSS pixels.
  #   dataTransfer: true # DataTransfer - The data that underlies a drag-and-drop operation, known as the drag data store. Protected mode.
  #   bubbles: true # boolean - Does the event normally bubble?
  #   cancelable: true # boolean - Is it possible to cancel the event?
  #   relatedTarget: true
  #   currentTarget: true
  #   type: true
  #   target: true # Event Target
  #   offsetX: true
  #   offsetY: true
  # }

  trigger = (target, type, origin, position) ->
    unless position
      stage = target.getStage()
      position = stage.point origin

    e =
      origin: origin
      type: type
      target: target
      offsetX: position.x
      offsetY: position.y

    target.trigger e.type, e

  event_fn = (type) ->
    (target, origin, position) ->
      trigger target, type, origin, position

  event_types = [
    'mousemove'
    'mousedown'
    'mouseup'
    'click'
    'doubleclick'
    'contextmenu'
    'mouseover'
    'mouseout'
    'dragstart'
    'drag'
    'dragend'
    'touchstart'
    'touchmove'
    'touchend'
    'longtouch'
    'tap'
    'doubletap'
  ]

  _.reduce event_types, (result, event_type) ->
    result[event_type] = event_fn(event_type)
    result
  , {}
