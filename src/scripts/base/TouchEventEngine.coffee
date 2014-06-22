# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

# TouchEventEngine은 캔버스에서 터치 이벤트가 발생했을 때
# 캔버스내의 컴포넌트 트리에서 최종 이벤트를 캡쳐하는 컴포넌트를 찾아낸 후
# 적절한 이벤트 가공을 통해서 Application까지 이벤트 버블링을 시키는 엔진이다.

define [
  './MouseEventEngine'
  '../util/Dimension'
  '../event/TouchEvent'
], (
  MouseEventEngine
  Dimension
  TouchEvent
) ->

  "use strict"

  calc_offset = (elem, e) ->
    touch = e.targetTouches[0]

    Dimension.page_to_offset elem,
      x: touch.pageX
      y: touch.pageY

  save_event = (e) ->
    return null unless e

    {
      type: e.type
      targetTouches: [{
        pageX: e.targetTouches[0].pageX
        pageY: e.targetTouches[0].pageY
      }]
    }

  ondragstart = (e, offset) ->
    @dragging = true
    TouchEvent.dragstart @captured, e, offset

  ondrag = (e, offset) ->
    TouchEvent.drag @captured, e, offset

    @event = save_event(e)

  ondragend = (e) ->
    TouchEvent.dragend @captured, e

    @dragging = false
    @captured = null
    @event = null

  onlongtouch = (e) ->

    @longtouchtimer = null
    @dragging = false
    TouchEvent.longtouch @captured, e if @captured

  ontouchstart = (e) ->
    e.preventDefault()

    self = @
    @longtouchtimer = setTimeout ->
      onlongtouch.call self, e
    , 500

    @event = save_event(e)

    offset = calc_offset(@stage.html_container, e)
    @captured = @capture @stage, offset

  ontouchmove = (e) ->
    e.preventDefault()

    if @dragging
      offset = calc_offset(@stage.html_container, e)
      return @ondrag e, offset

    if @longtouchtimer
      clearTimeout(@longtouchtimer)
      @longtouchtimer = null
    else
      return

    lastEvent = save_event(@event)

    @event = save_event(e)

    lastCaptured = @captured

    offset = calc_offset(@stage.html_container, e)
    @captured = @stage.capture offset

    if lastEvent && lastEvent.type == 'touchstart' && lastCaptured.get('draggable')
      return @ondragstart e, offset

  ontouchend = (e) ->
    e.preventDefault()

    if @longtouchtimer
      clearTimeout(@longtouchtimer)
      @longtouchtimer = null

    @event = e
    if @dragging
      return @ondragend e

    @captured = null
    @event = null

  class TouchEventEngine extends MouseEventEngine

    constructor: (@stage) ->
      @ontouchstart = ontouchstart.bind(@)
      @ontouchmove = ontouchmove.bind(@)
      @ontouchend = ontouchend.bind(@)

      @ondragstart = ondragstart.bind(@)
      @ondragend = ondragend.bind(@)
      @ondrag = ondrag.bind(@)

      @stage.html_container.addEventListener 'touchstart', @ontouchstart
      @stage.html_container.addEventListener 'touchmove', @ontouchmove
      @stage.html_container.addEventListener 'touchend', @ontouchend

      @

    dispose: ->
      @stage.html_container.removeEventListener 'touchstart', @ontouchstart
      @stage.html_container.removeEventListener 'touchmove', @ontouchmove
      @stage.html_container.removeEventListener 'touchend', @ontouchend
