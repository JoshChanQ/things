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

  trigger = (target, type, origin) ->

    e =
      origin: origin
      type: type
      target: target
      offsetX: origin.offsetX + (if origin.target.tagName == 'CANVAS' then origin.target.offsetLeft else 0)
      offsetY: origin.offsetY + (if origin.target.tagName == 'CANVAS' then origin.target.offsetTop else 0)

    target.trigger e.type, e

  event_fn = (type) ->
    (target, origin) ->
      trigger target, type, origin

  event_types = [
    'mousemove'
    'mousedown'
    'mouseup'
    'click'
    'contextmenu'
    'mouseover'
    'mouseout'
    'dragstart'
    'drag'
    'dragend'
  ]

  _.reduce event_types, (result, event_type) ->
    result[event_type] = event_fn(event_type)
    result
  , {}
