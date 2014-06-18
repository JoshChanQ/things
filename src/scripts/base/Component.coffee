# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Module'
  './Property'
  './LifeCycle'
  './Event'
  './Serialize'
], (
  Module
  Property
  LifeCycle
  Event
  Serialize
) ->

  "use strict"

  class Component extends Module
    @include Property
    @include LifeCycle
    @include Event
    @include Serialize

    constructor : (type, container) ->
      @type = type
      @container = container

    getType : ->
      @type

    dispose : ->
      @setContainer null

    getContainer : ->
      @container

    setContainer : (container) ->
      return if container is @container

      if @container
        @container.remove this

      @container = container
      if @container
        @container.add this

    moveAt: (index) ->
      return if not @getContainer()
      @container.moveChildAt(index, this)

    moveForward: ->
      return if not @getContainer()
      @container.moveChildForward(this)

    moveBackward: ->
      return if not @getContainer()
      @container.moveChildBackward(this)

    moveToFront: ->
      return if not @getContainer()
      @container.moveChildToFront(this)

    moveToBack: ->
      return if not @getContainer()
      @container.moveChildToBack(this)
