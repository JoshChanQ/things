# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Controller'
], (
  Controller
) ->

  'use strict'

  stages = []

  {
    # 어플리케이션을 만들면서, 그 어플리케이션에 컨텍스트를 제공한다.
    create: (options) ->
      stage = new Controller(options).getStage()
      stages.push stage
      stage

    destroy: (stage) ->
      idx = stages.indexOf stage
      stages.splice(idx, 1) if idx > -1

      stage.dispose()

    stages: ->
      stages
  }
