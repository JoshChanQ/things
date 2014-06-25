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

  ondragstart = (e, position) ->
    @dragging = true

    PointEvent.dragstart @captured, e, position

    if (e.preventDefault)
      e.preventDefault()

  ondrag = (e, position) ->
    PointEvent.drag @captured, e, position
    @event = e

    if (e.preventDefault)
      e.preventDefault()

  ondragend = (e, position) ->
    PointEvent.dragend @captured, e, position
    @dragging = false

    if (e.preventDefault)
      e.preventDefault()

  onmousedown = (e) ->
    @event = e
    @listening_drag = true

  onmouseup = (e) ->
    # TODO Double Click Support

    @event = e
    @listening_drag = false

    position = @stage.point e

    if @dragging
      return @ondragend e, position

    @captured = @stage.capture position
    PointEvent.click @captured, e, position

  # onmousemove = (e) ->

  #   # workaround fake mousemove event in chrome browser https://code.google.com/p/chromium/issues/detail?id=161464
  #   return if ((typeof e.webkitMovementX != 'undefined' || typeof e.webkitMovementY != 'undefined') && e.webkitMovementY == 0 && e.webkitMovementX == 0)

  #   position = @stage.point e

  #   lastEvent = @event
  #   @event = e

  #   lastCaptured = @captured

  #   @captured = @stage.capture position

  #   # if lastEvent && lastEvent.type == 'mousedown' && lastCaptured.get('draggable')
  #   #   return @ondragstart e, position

  #   if @captured == lastCaptured
  #     PointEvent.mousemove @captured, e, position
  #     return

  #   newAscendant = [@captured]
  #   newAscendant.unshift(component) while component = (component||@captured).getContainer()

  #   oldAscendant = [lastCaptured]
  #   oldAscendant.unshift(component) while component = (component||lastCaptured).getContainer() if lastCaptured

  #   while oldAscendant[0] == newAscendant[0]
  #     oldAscendant.shift()
  #     newAscendant.shift()

  #   PointEvent.mouseout component, e ,position while component = oldAscendant.pop()
  #   PointEvent.mouseover component, e, position while component = newAscendant.shift()

  #   # 마우스 버튼이 눌린 상태여야 함.
  #   DragAndDrop.drag @captured, e, position if @listening_drag

  #   if e.preventDefault
  #     e.preventDefault()

  onmousemove = (e) ->

    # workaround fake mousemove event in chrome browser https://code.google.com/p/chromium/issues/detail?id=161464
    return if ((typeof e.webkitMovementX != 'undefined' || typeof e.webkitMovementY != 'undefined') && e.webkitMovementY == 0 && e.webkitMovementX == 0)

    position = @stage.point e

    if @dragging
      return @ondrag e, position

    lastEvent = @event
    @event = e

    lastCaptured = @captured

    @captured = @stage.capture position

    if lastEvent && lastEvent.type == 'mousedown' && lastCaptured.get('draggable')
      return @ondragstart e, position

    if @captured == lastCaptured
      PointEvent.mousemove @captured, e, position
      return

    newAscendant = [@captured]
    newAscendant.unshift(component) while component = (component||@captured).getContainer()

    oldAscendant = [lastCaptured]
    oldAscendant.unshift(component) while component = (component||lastCaptured).getContainer() if lastCaptured

    while oldAscendant[0] == newAscendant[0]
      oldAscendant.shift()
      newAscendant.shift()

    PointEvent.mouseout component, e ,position while component = oldAscendant.pop()
    PointEvent.mouseover component, e, position while component = newAscendant.shift()

    # always call preventDefault for desktop events because some browsers
    # try to drag and drop the canvas element
    if (e.preventDefault)
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
    @event = null

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
      @ondragstart = ondragstart.bind(@)
      @ondragend = ondragend.bind(@)
      @ondrag = ondrag.bind(@)
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
