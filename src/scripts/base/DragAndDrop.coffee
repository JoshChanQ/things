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

  onbefore_end_drag = (e) ->
    target = DragAndDrop.target

    if target

      # only fire dragend event if the drag and drop
      # operation actually started.
      if DragAndDrop.dragging
        DragAndDrop.dragging = false

        DragAndDrop.drag_end_target = target

      delete DragAndDrop.target

  onafter_end_drag = (e) ->

      drag_end_target = DragAndDrop.drag_end_target

      if drag_end_target
        position = drag_end_target.getStage().point(e)
        PointEvent.dragend DragAndDrop.drag_end_target, e, position
        drag_end_target.debug 'dragend', position.x + ':' + position.y

      delete DragAndDrop.drag_end_target

      DragAndDrop.cleanup()

  DragAndDrop =
    dragging: false

    target: null
    drag_end_target: null

    start_point: null
    last_point: null

    cutoff: 5

    cleanup: ->
      @target = null
      @drag_end_target = null

      @start_point = null
      @last_point = null

      dragging = false

    drag: (target, e, position) ->
      @start_point = position unless @start_point

      if !@dragging && target.get('draggable')
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

  document.addEventListener 'mouseup', onbefore_end_drag, true
  document.addEventListener 'touchend', onbefore_end_drag, true

  document.addEventListener 'mouseup', onafter_end_drag, false
  document.addEventListener 'touchend', onafter_end_drag, false

  DragAndDrop
