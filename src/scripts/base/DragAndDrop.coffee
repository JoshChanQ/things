# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../event/PointEvent'
], (
  PointEvent
) ->

  onbefore_mouseup = (e) ->

  onafter_mouseup = (e) ->
    DragAndDrop.dragging = false

    target = DragAndDrop.target

    if target
      position = target.getStage().point(e)
      PointEvent.dragend DragAndDrop.target, e, position

    delete DragAndDrop.target

    DragAndDrop.cleanup()

  # onbefore_end_drag = (e) ->
  #   target = DragAndDrop.target

  #   if target

  #     # only fire dragend event if the drag and drop
  #     # operation actually started.
  #     if DragAndDrop.dragging
  #       DragAndDrop.dragging = false

  #       DragAndDrop.drag_end_target = target

  #     delete DragAndDrop.target

  # onafter_end_drag = (e) ->

  #     drag_end_target = DragAndDrop.drag_end_target

  #     if drag_end_target
  #       position = drag_end_target.getStage().point(e)
  #       PointEvent.dragend DragAndDrop.drag_end_target, e, position

  #     delete DragAndDrop.drag_end_target

  #     DragAndDrop.cleanup()

  DragAndDrop =

    # draggable - Mouse의 왼쪽 버튼이 눌린다든지하는 경우에
    # 필요시에 외부에서 true로 설정하고, 여기 cleanup 로직에서 false로 만들어준다.
    draggable: false
    dragging: false

    target: null
    drag_end_target: null

    start_point: null
    last_point: null

    cutoff: 4

    cleanup: ->
      @target = null
      @drag_end_target = null

      @start_point = null
      @last_point = null

      @dragging = false
      @draggable = false

    drag: (target, e, position) ->
      @start_point = position unless @start_point

      if !@dragging && target.get('draggable')
        if e.touches != undefined
          distance = Math.max(
            Math.abs(position.x - @start_point.x),
            Math.abs(position.y - @start_point.y)
          )
          return if distance < @cutoff

        @dragging = true
        @target = target
        PointEvent.dragstart target, e, @start_point

      if @dragging
        @last_point = position
        PointEvent.drag @target, e, position

  document.addEventListener 'mouseup', onbefore_mouseup, true
  document.addEventListener 'touchend', onbefore_mouseup, true

  document.addEventListener 'mouseup', onafter_mouseup, false
  document.addEventListener 'touchend', onafter_mouseup, false

  DragAndDrop
