# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../menu/ContextMenu'
], (
  ContextMenu
) ->

  'use strict'

  onadd = (container, component, index, e) ->
    # register event_map of the added component
    # TODO should register events for all decendents recursively
    if component.event_map
      maps = component.event_map()
      @eventEngine.add(component, maps, component)

    component.onadded(container) if component.onadded

    component.draw()

  onremove = (container, component) ->
    component.onremoved(container) if component.onremoved

    # unregister event_map of the removed component
    # TODO should unregister events for all decendents recursively
    @eventEngine.remove(component)

  oncontextmenu = (e, context) ->
    ContextMenu.show
      x: e.origin.pageX
      y: e.origin.pageY

  onchange = (target, before, after) ->
    # TODO 이거는 고민을 좀 해봐야 한다..
    @stage.html_container.style.width = after['w'] + 'px' if after.hasOwnProperty('w')
    @stage.html_container.style.height = after['h'] + 'px' if after.hasOwnProperty('h')

  [
    ContextMenu
    {
      '(root)':
        '(root)':
          'change': onchange
        '(all)':
          'add': onadd
          'remove': onremove
          'contextmenu': oncontextmenu
          'longtouch': oncontextmenu
    }
  ]
