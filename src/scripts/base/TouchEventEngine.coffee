# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

# TouchEventEngine은 캔버스에서 터치 이벤트가 발생했을 때
# 캔버스내의 컴포넌트 트리에서 최종 이벤트를 캡쳐하는 컴포넌트를 찾아낸 후
# 적절한 이벤트 가공을 통해서 Stage까지 이벤트 버블링을 시키는 엔진이다.

define [
  '../event/PointEvent'
  './DragAndDrop'
], (
  PointEvent
  DragAndDrop
) ->

  "use strict"

  ontouchstart = (e) ->

    position = @stage.point e

    target = @stage.capture position

    # ready to detect tap event
    @tap_target = target

    # ready to detect long touch event
    self = @
    @longtouch_triggered = false
    @longtouch_timer = setTimeout ->
      self.longtouch_timer = null
      PointEvent.longtouch target, e, position if target
      self.longtouch_triggered = true
    , 500

    PointEvent.touchstart target, e, position

    if e.preventDefault
      e.preventDefault()

  ontouchend = (e) ->

    position = @stage.point e

    target = @stage.capture position

    if @longtouch_timer
      clearTimeout(@longtouch_timer)
      @longtouch_timer = null

    dbl_click_detected = false

    if @listening_dbl_click
      dbl_click_detected = true
      @listening_dbl_click = false
    else
      @listening_dbl_click = true

    self = @
    setTimeout ->
      self.listening_dbl_click = false
    , 500

    if target && !DragAndDrop.dragging
      PointEvent.touchend target, e, position

      # detect if tap or double tap occurred
      if @tap_target && target == @tap_target
        PointEvent.tap target, e, position

        if dbl_click_detected
          PointEvent.doubletap target, e, position
          @listening_dbl_click = false

    @tap_target = null

    if e.preventDefault
      e.preventDefault()

  ontouchmove = (e) ->
    position = @stage.point e

    if @longtouch_timer && DragAndDrop.dragging
      clearTimeout(@longtouch_timer)
      @longtouch_timer = null
    else if @longtouch_triggered
      if e.preventDefault
        e.preventDefault()
      return

    target = @stage.capture position

    if !DragAndDrop.dragging && target
      PointEvent.touchmove target, e, position

      if e.preventDefault
        e.preventDefault()

    DragAndDrop.drag target, e, position

    if e.preventDefault
      e.preventDefault()

  class TouchEventEngine

    constructor: (@stage) ->
      @ontouchstart = ontouchstart.bind(@)
      @ontouchmove = ontouchmove.bind(@)
      @ontouchend = ontouchend.bind(@)

      @stage.html_container.addEventListener 'touchstart', @ontouchstart
      @stage.html_container.addEventListener 'touchmove', @ontouchmove
      @stage.html_container.addEventListener 'touchend', @ontouchend

      @

    dispose: ->
      @stage.html_container.removeEventListener 'touchstart', @ontouchstart
      @stage.html_container.removeEventListener 'touchmove', @ontouchmove
      @stage.html_container.removeEventListener 'touchend', @ontouchend
