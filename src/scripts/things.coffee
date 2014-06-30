# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Controller'
  './base/Component'
  './base/Container'

  './plugin/shape/Barcode'
  './plugin/shape/Circle'
  './plugin/shape/Ellipse'
  './plugin/shape/ImageBox'
  './plugin/shape/Path'
  './plugin/shape/Rect'
  './plugin/shape/Ruler'
  './plugin/shape/Shape'
  './plugin/shape/Text'
  './plugin/shape/Line'

  './plugin/layer/DebugLayer'
  './plugin/layer/Layer'
  './plugin/layer/MagnifyLayer'
  './plugin/layer/RulerLayer'
  './plugin/layer/SelectionLayer'
  './plugin/layer/SlideLayer'
  './plugin/layer/WidgetLayer'

  './plugin/group/Group'

  './plugin/handle/BoundHandle'
  './plugin/handle/CircleHandle'
  './plugin/handle/Handle'
  './plugin/handle/P2PHandle'
  './plugin/handle/PathHandle'
  './plugin/handle/RotationHandle'

  './plugin/stage/Stage'
  './plugin/stage/WidgetBox'
], (
  Controller
  Component
  Container

  Barcode
  Circle
  Ellipse
  ImageBox
  Path
  Rect
  Ruler
  Shape
  Text
  Line

  DebugLayer
  Layer
  MagnifyLayer
  RulerLayer
  SelectionLayer
  SlideLayer
  WidgetLayer

  Group

  BoundHandle
  CircleHandle
  Handle
  P2PHandle
  PathHandle
  RotationHandle

  Stage
  WidgetBox
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

    Component: Component
    Container: Container

    shape:
      Barcode: Barcode
      Circle: Circle
      Ellipse: Ellipse
      ImageBox: ImageBox
      Path: Path
      Rect: Rect
      Ruler: Ruler
      Shape: Shape
      Text: Text
      Line: Line

    layer:
      DebugLayer: DebugLayer
      Layer: Layer
      MagnifyLayer: MagnifyLayer
      RulerLayer: RulerLayer
      SelectionLayer: SelectionLayer
      SlideLayer: SlideLayer
      WidgetLayer: WidgetLayer

    group:
      Group: Group

    handle:
      BoundHandle: BoundHandle
      CircleHandle: CircleHandle
      Handle: Handle
      P2PHandle: P2PHandle
      PathHandle: PathHandle
      RotationHandle: RotationHandle

    stage:
      Stage: Stage
      WidgetBox: WidgetBox
  }
