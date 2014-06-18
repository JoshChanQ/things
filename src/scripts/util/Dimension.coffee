# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  'use strict'

  page_to_offset = (element, page) ->
    element_bound = offset_rect(element)

    {
      x: page.x - element_bound.left
      y: page.y - element_bound.top
    }

  offset_rect = (element) ->
    box = element.getBoundingClientRect()

    body = document.body
    docElem = document.documentElement

    scrollTop = window.pageYOffset || docElem.scrollTop || body.scrollTop
    scrollLeft = window.pageXOffset || docElem.scrollLeft || body.scrollLeft

    clientTop = docElem.clientTop || body.clientTop || 0
    clientLeft = docElem.clientLeft || body.clientLeft || 0

    top  = box.top +  scrollTop - clientTop
    left = box.left + scrollLeft - clientLeft

    {
      top: Math.round(top)
      left: Math.round(left)
    }

  {
    page_to_offset: page_to_offset
  }
