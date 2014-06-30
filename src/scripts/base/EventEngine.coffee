# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../util/Util'
  './EventPump'
  './ComponentSelector'
], (
  _
  EventPump
  ComponentSelector
) ->

  "use strict"

  class EventEngine
    constructor: (root) ->
      @eventMaps = []
      @setRoot(root)

    setRoot: (root) ->
      @root = root

    stop: ->
      for item in @eventMaps
        item.eventPump.stop()

    add: (listener, handlerMaps, context) ->
      return unless @root

      unless handlerMaps instanceof Array
        @add listener, [handlerMaps], context
        return

      for handlerMap in handlerMaps
        for own selector, handlers of handlerMap

          if selector.indexOf('?') == 0
            variable = selector.substr(1)
            value = listener.get(variable)

            if value
              selector = value
            else
              console.log("EventEngine#add", "variable #{selector} is not evaluated on listener")
              continue

          targets = ComponentSelector.select(selector, @root, listener)

          for target in targets
            eventPump = new EventPump(target)
            eventPump.on(listener, handlers)
            eventPump.start(context)

            @eventMaps.push
              eventPump: eventPump
              listener: listener
              handlerMap: handlerMap
              target: target

    remove: (listener, handlerMap) ->
      maps = _.clone @eventMaps
      for item, index in maps
        if item.listener is listener and (!handlerMap or item.handlerMap is handlerMap)
          @eventMaps.splice(index, 1)
          item.eventPump.dispose()

    clear: ->
      maps = _.clone @eventMaps
      for eventMap in maps
        eventMap.eventPump.dispose()

      @eventMaps = []

    dispose: ->
      @stop()
      @clear()

  EventEngine
