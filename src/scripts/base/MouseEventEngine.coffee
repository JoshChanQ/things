# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

# MouseEventEngine은 캔버스에서 마우스 이벤트가 발생했을 때
# 캔버스내의 컴포넌트 트리에서 최종 이벤트를 캡쳐하는 컴포넌트를 찾아낸 후
# 적절한 이벤트 가공을 통해서 Stage까지 이벤트 버블링을 시키는 엔진이다.

define [
  '../base/DragAndDrop'
  '../event/PointEvent'
], (
  DragAndDrop
  PointEvent
) ->

  "use strict"

  onmousedown = (e) ->
    position = @stage.point e

    @captured = @stage.capture position

    # ready to detect click event.
    @click_target = @captured

    # draggable flag will be reset when mouse button goes to up
    DragAndDrop.draggable = true

    PointEvent.mousedown @captured, e, position

    if e.preventDefault
      e.preventDefault()

  onmouseup = (e) ->

    position = @stage.point e

    @captured = @stage.capture position

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

    if @captured && !DragAndDrop.dragging
      PointEvent.mouseup @captured, e, position

      # detect if click or double click occurred
      if @click_target && @captured == @click_target
        PointEvent.click @captured, e, position

        if dbl_click_detected
          PointEvent.doubleclick @captured, e, position
          @listening_dbl_click = false

    @click_target = null

    if e.preventDefault
      e.preventDefault()

  onmousemove = (e) ->

    # workaround fake mousemove event in chrome browser https://code.google.com/p/chromium/issues/detail?id=161464
    return if ((typeof e.webkitMovementX != 'undefined' || typeof e.webkitMovementY != 'undefined') && e.webkitMovementY == 0 && e.webkitMovementX == 0)

    position = @stage.point e

    lastCaptured = @captured

    @captured = @stage.capture position

    if !DragAndDrop.dragging

      PointEvent.mousemove @captured, e, position if @captured

      if @captured != lastCaptured

        newAscendant = [@captured]
        newAscendant.unshift(component) while component = (component||@captured).getContainer() if @captured

        oldAscendant = [lastCaptured]
        oldAscendant.unshift(component) while component = (component||lastCaptured).getContainer() if lastCaptured

        while oldAscendant[0] == newAscendant[0]
          oldAscendant.shift()
          newAscendant.shift()

        PointEvent.mouseout component, e ,position while component = oldAscendant.pop()
        PointEvent.mouseover component, e, position while component = newAscendant.shift()

    DragAndDrop.drag @captured, e, position if DragAndDrop.draggable && @captured

    if e.preventDefault
      e.preventDefault()

  onmouseleave = (e) ->
    if @dragging
      return

    if @captured
      position = @stage.point e

      component = @captured
      oldAscendant = [@captured]
      oldAscendant.unshift(component) while component = component.getContainer()
      PointEvent.mouseout component, e, position while component = oldAscendant.pop()

    @captured = null

  onmouseenter = (e) ->

  oncontextmenu = (e) ->
    e.preventDefault()

    position = @stage.point e
    @captured = @stage.capture position

    PointEvent.contextmenu @captured, e, position

  class MouseEventEngine

    constructor: (@stage) ->
      @onmousemove = onmousemove.bind(@)
      @onmouseleave = onmouseleave.bind(@)
      @onmouseenter = onmouseenter.bind(@)
      @onmouseup = onmouseup.bind(@)
      @onmousedown = onmousedown.bind(@)
      @oncontextmenu = oncontextmenu.bind(@)

      @stage.html_container.addEventListener 'mousemove', @onmousemove
      @stage.html_container.addEventListener 'mouseleave', @onmouseleave
      @stage.html_container.addEventListener 'mouseenter', @onmouseenter
      @stage.html_container.addEventListener 'mouseup', @onmouseup
      @stage.html_container.addEventListener 'mousedown', @onmousedown
      @stage.html_container.addEventListener 'contextmenu', @oncontextmenu

      @

    dispose: ->
      @stage.html_container.removeEventListener 'mousemove', @onmousemove
      @stage.html_container.removeEventListener 'mouseleave', @onmouseleave
      @stage.html_container.removeEventListener 'mouseenter', @onmouseenter
      @stage.html_container.removeEventListener 'mouseup', @onmouseup
      @stage.html_container.removeEventListener 'mousedown', @onmousedown
      @stage.html_container.removeEventListener 'contextmenu', @oncontextmenu
