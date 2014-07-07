# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  './Controller'
  './base/Component'
  './base/Container'

  './Stage'
  './Layer'
  './Group'
  './Shape'

  './Animation'

  './plugin/shape/Barcode'
  './plugin/shape/Circle'
  './plugin/shape/Ellipse'
  './plugin/shape/ImageBox'
  './plugin/shape/Path'
  './plugin/shape/Rect'
  './plugin/shape/Ruler'
  './plugin/shape/Text'
  './plugin/shape/Line'

  './plugin/layer/DebugLayer'
  './plugin/layer/MagnifyLayer'
  './plugin/layer/RulerLayer'
  './plugin/layer/SelectionLayer'
  './plugin/layer/SlideLayer'
  './plugin/layer/WidgetLayer'

  './plugin/handle/BoundHandle'
  './plugin/handle/CircleHandle'
  './plugin/handle/Handle'
  './plugin/handle/P2PHandle'
  './plugin/handle/PathHandle'
  './plugin/handle/RotationHandle'
], (
  Controller
  Component
  Container

  Stage
  Layer
  Group
  Shape

  Animation

  Barcode
  Circle
  Ellipse
  ImageBox
  Path
  Rect
  Ruler
  Text
  Line

  DebugLayer
  MagnifyLayer
  RulerLayer
  SelectionLayer
  SlideLayer
  WidgetLayer

  BoundHandle
  CircleHandle
  Handle
  P2PHandle
  PathHandle
  RotationHandle
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
    Animation: Animation

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
  }
