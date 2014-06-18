# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  'use strict'

  onadd = (container, component, index, e) ->
    # register event_map of the added component
    # TODO should register events for all decendents recursively
    return unless component.event_map

    maps = component.event_map()

    @eventEngine.add(component, maps, component)

  onremove = (container, component) ->
    # unregister event_map of the removed component
    # TODO should unregister events for all decendents recursively
    @eventEngine.remove(component)

  {
    '(root)':
      '(all)':
        'add': onadd
        'remove': onremove
  }
