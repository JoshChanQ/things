# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

# MouseEventEngine은 캔버스에서 마우스 이벤트가 발생했을 때
# 캔버스내의 컴포넌트 트리에서 최종 이벤트를 캡쳐하는 컴포넌트를 찾아낸 후
# 적절한 이벤트 가공을 통해서 Application까지 이벤트 버블링을 시키는 엔진이다.

define [
  '../event/MouseEvent'
], (
  MouseEvent
) ->

  "use strict"

  convert_offset = (e, position)->
    return position unless e.target.tagName == 'CANVAS'

    newposition =
      x: position.x + e.target.offsetLeft
      y: position.y + e.target.offsetTop

  ondragstart = (e) ->
    @dragging = true
    MouseEvent.dragstart @captured, e

    if (e.preventDefault)
      e.preventDefault()

  ondrag = (e) ->
    MouseEvent.drag @captured, e
    @event = e

    if (e.preventDefault)
      e.preventDefault()

  ondragend = (e) ->
    MouseEvent.dragend @captured, e
    @dragging = false

    if (e.preventDefault)
      e.preventDefault()

  onmousedown = (e) ->
    @event = e

  onmouseup = (e) ->
    # TODO Double Click Support

    @event = e
    if @dragging
      return @ondragend e

    position = convert_offset e,
      x: e.offsetX
      y: e.offsetY

    @captured = @stage.capture position
    MouseEvent.click @captured, e

  onmousemove = (e) ->

    # workaround fake mousemove event in chrome browser https://code.google.com/p/chromium/issues/detail?id=161464
    return if ((typeof e.webkitMovementX != 'undefined' || typeof e.webkitMovementY != 'undefined') && e.webkitMovementY == 0 && e.webkitMovementX == 0)

    if @dragging
      return @ondrag e

    lastEvent = @event
    @event = e

    lastCaptured = @captured

    position = convert_offset e,
      x: e.offsetX
      y: e.offsetY

    @captured = @stage.capture position

    if lastEvent && lastEvent.type == 'mousedown' && lastCaptured.get('draggable')
      return @ondragstart e

    if @captured == lastCaptured
      MouseEvent.mousemove @captured, e
      return

    newAscendant = [@captured]
    newAscendant.unshift(component) while component = (component||@captured).getContainer()

    oldAscendant = [lastCaptured]
    oldAscendant.unshift(component) while component = (component||lastCaptured).getContainer() if lastCaptured

    while oldAscendant[0] == newAscendant[0]
      oldAscendant.shift()
      newAscendant.shift()

    MouseEvent.mouseout component, e while component = oldAscendant.pop()
    MouseEvent.mouseover component, e while component = newAscendant.shift()

    # always call preventDefault for desktop events because some browsers
    # try to drag and drop the canvas element
    if (e.preventDefault)
      e.preventDefault()

  onmouseleave = (e) ->
    if @dragging
      return

    if @captured
      component = @captured
      oldAscendant = [@captured]
      oldAscendant.unshift(component) while component = component.getContainer()
      MouseEvent.mouseout component, e while component = oldAscendant.pop()

    @captured = null
    @event = null

  onmouseenter = (e) ->

  oncontextmenu = (e) ->
    e.preventDefault()

    position = convert_offset e,
      x: e.offsetX
      y: e.offsetY

    @captured = @stage.capture position

    MouseEvent.contextmenu @captured, e

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
