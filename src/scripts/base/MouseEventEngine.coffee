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

  ondragstart = (e) ->
    @dragging = true
    MouseEvent.dragstart @captured, e

  ondrag = (e) ->
    MouseEvent.drag @captured, e
    @event = e

  ondragend = (e) ->
    MouseEvent.dragend @captured, e
    @dragging = false

  onmousedown = (e) ->
    @event = e

  onmouseup = (e) ->
    @event = e
    if @dragging
      return @ondragend e

  onmousemove = (e) ->
    # TODO 여기서부터 - offset 위치 정보를 만드는 부분을 정비해야 함.
    if @event && (@event.target != e.target)
      return
    # 여기까지.

    if @dragging
      return @ondrag e

    lastEvent = @event
    @event = e

    lastCaptured = @captured
    @captured = @capture @app,
      x: e.offsetX
      y: e.offsetY

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

  onclick = (e) ->
    @captured = @capture @app,
      x: e.offsetX
      y: e.offsetY

    MouseEvent.click @captured, e

  oncontextmenu = (e) ->
    e.preventDefault()

    @captured = @capture @app,
      x: e.offsetX
      y: e.offsetY

    MouseEvent.contextmenu @captured, e

  class MouseEventEngine

    constructor: (@app) ->
      @onmousemove = onmousemove.bind(@)
      @onmouseleave = onmouseleave.bind(@)
      @onmouseenter = onmouseenter.bind(@)
      @onmouseup = onmouseup.bind(@)
      @onmousedown = onmousedown.bind(@)
      @ondragstart = ondragstart.bind(@)
      @ondragend = ondragend.bind(@)
      @ondrag = ondrag.bind(@)
      @onclick = onclick.bind(@)
      @oncontextmenu = oncontextmenu.bind(@)

      @app.html_container.addEventListener 'mousemove', @onmousemove
      @app.html_container.addEventListener 'mouseleave', @onmouseleave
      @app.html_container.addEventListener 'mouseenter', @onmouseenter
      @app.html_container.addEventListener 'mouseup', @onmouseup
      @app.html_container.addEventListener 'mousedown', @onmousedown
      @app.html_container.addEventListener 'click', @onclick
      @app.html_container.addEventListener 'contextmenu', @oncontextmenu

      @

    capture: (target, position, context) ->
      if target.constructor.spec.container_type == 'layer'
        context = target.canvas.getContext '2d'
        position =
          x: position.x - (target.get('offset-x') || 0)
          y: position.y - (target.get('offset-y') || 0)

      unless target.constructor.spec.containable
        if target.get('capturable') != false && target.capture(position, context)
          return target
        else
          return

      return unless target.isPointInBound(position)

      captured = null

      if target.size() > 0
        for i in [(target.size() - 1)..0]
          component = target.getAt(i)
          captured = @capture component, position, context
          return captured if captured

      return captured if captured
      return target if target.get('capturable') != false && target.capture(position, context)

      return null

    dispose: ->
      @app.html_container.removeEventListener 'mousemove', @onmousemove
      @app.html_container.removeEventListener 'mouseleave', @onmouseleave
      @app.html_container.removeEventListener 'mouseenter', @onmouseenter
      @app.html_container.removeEventListener 'mouseup', @onmouseup
      @app.html_container.removeEventListener 'mousedown', @onmousedown
      @app.html_container.removeEventListener 'click', @onclick
      @app.html_container.removeEventListener 'contextmenu', @oncontextmenu
