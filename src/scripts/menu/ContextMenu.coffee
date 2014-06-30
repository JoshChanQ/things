# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  'use strict'

  template =
    '<ul id="context-menu" class="things-context-menu">
      <li><a href="http://cooking.hatiolab.com/">Cooking</a></li>
      <li><a href="http://www.naver.com">Naver</a></li>
    </ul>'

  container = document.createElement('div')
  container.style.position = 'absolute'
  container.style.display = 'inline-block'
  container.style.zIndex = 1000
  document.body.appendChild container
  container.innerHTML = template
  contextmenu = document.getElementById('context-menu')

  handler = (e) ->
    document.removeEventListener 'click', handler
    document.removeEventListener 'touchstart', handler
    setTimeout(hide, 100)

  show = (position) ->
    container.style.top = position.y + 'px'
    container.style.left = position.x + 'px'
    contextmenu.style.display = 'block'

    document.addEventListener 'click', handler
    document.addEventListener 'touchstart', handler

  hide = ->
    contextmenu.style.display = 'none'

  {
    show: show
    hide: hide
  }
