# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../util/Util'
  './Component'
  '../event/ComponentEvent'
], (
  _
  Component
  ComponentEvent
) ->

  "use strict"

  EMPTY = []

  add_component = (container, component) ->
    containable = component instanceof Component
    if containable
      oldContainer = component.getContainer()

      if oldContainer
        return if container is oldContainer
        remove_component(container, component)

    index = (container.__components__.push component) - 1
    component.setContainer(container) if containable

    ComponentEvent.add container, container, component, index

    return if not containable

    component.delegate_on container

    ComponentEvent.added component, container, component, index

  remove_component = (container, component) ->
    containable = component instanceof Component

    idx = container.__components__.indexOf component

    return if idx is -1

    container.__components__.splice(idx, 1) if idx > -1

    component.setContainer(null) if containable

    ComponentEvent.remove container, container, component

    return if not (component instanceof Component)

    ComponentEvent.removed component, container, component

    component.delegate_off container

  add = (comp) ->
    @__components__ || @__components__ = []

    return add.call(this, [comp]) if not (comp instanceof Array)
    add_component(this, i) for i in comp

    this

  remove = (comp) ->
    return remove.call(this, [comp]) if not (comp instanceof Array)

    return if not @__components__

    for i in comp
      remove_component this, i

    this

  removeAll = ->
    @remove _.clone @__components__

  getAt = (index) ->
    return @__components__[index] if @__components__

  forEach = (fn, context) ->
    return if not @__components__
    @__components__.forEach(fn, context)

  indexOf = (item) ->
    (@__components__ || EMPTY).indexOf(item)

  size = ->
    (@__components__ || EMPTY).length

  isAscendentOf = (component) ->
    return false unless component
    return true if @ is component.getContainer()

    return @isAscendentOf(component.getContainer())

  moveChildAt = (index, child) ->
    oldIndex = @indexOf(child)
    return if oldIndex is -1
    head = @__components__.splice(0, oldIndex)
    tail = @__components__.splice(1)
    @__components__ = head.concat(tail)

    index = Math.max(0, index)
    index = Math.min(index, @__components__.length)

    head = @__components__.splice(0, index)
    @__components__ = head.concat(child, @__components__)

  moveChildForward = (child) ->
    index = @indexOf(child)
    return if (index is -1) or (index is @size() - 1)
    @__components__[index] = @__components__[index + 1]
    @__components__[index + 1] = child

  moveChildBackward = (child) ->
    index = @indexOf(child)
    return if index is -1 or index is 0
    @__components__[index] = @__components__[index - 1]
    @__components__[index - 1] = child

  moveChildToFront = (child) ->
    index = @indexOf(child)
    return if index is -1 or (index is @size() - 1)
    head = @__components__.splice(0, index)
    tail = @__components__.splice(1)
    @__components__ = head.concat(tail, @__components__)

  moveChildToBack = (child) ->
    index = @indexOf(child)
    return if index is -1 or index is 0
    head = @__components__.splice(0, index)
    tail = @__components__.splice(1)
    @__components__ = @__components__.concat(head, tail)

  class Container extends Component
    constructor: (type) ->
      super(type)

    dispose: ->
      if @__components__
        children = _.clone(@__components__)

        for component in children
          component.dispose()
        @__components__ = null

      super()

    add: add
    remove: remove
    removeAll: removeAll
    size: size
    getAt: getAt
    indexOf: indexOf
    forEach: forEach
    isAscendentOf: isAscendentOf
    moveChildAt: moveChildAt
    moveChildForward: moveChildForward
    moveChildBackward: moveChildBackward
    moveChildToFront: moveChildToFront
    moveChildToBack: moveChildToBack

  Container
