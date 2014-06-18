# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  'use strict'

  add = (target, container, component, index) ->
    target.trigger 'add', container, component, index

  added = (target, container, component, index) ->
    target.trigger 'added', container, component, index

  remove = (target, container, component) ->
    target.trigger 'remove', container, component

  removed = (target, container, component) ->
    target.trigger 'removed', container, component

  {
    add: add
    added: added
    remove: remove
    removed: removed
  }
