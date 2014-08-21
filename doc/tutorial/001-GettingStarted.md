# 처음 시작하기
things를 가지고 처음 시작하기
## 웹페이지에 추가할 것들
### javascript
```
<script src="../lodash/dist/lodash.js"></script>
<script src="../io-things/dist/things.js"></script>
```
### stylesheet
```
<link rel="stylesheet" href="things-stage.css" />
```
## Stage 만들기
Stage가 추가되는 컨테이너로`<div>` 엘리먼트를 준비해야 한다.
things.create API로 Stage를 만들 수 있다.
```
var stage = things.create({
    container: 'stage-container',
    w: 400,
    h: 300
});
```
폭 400픽셀, 높이 300픽셀 크기의 Stage를 'stage-container'라는 id를 가진 div 엘리먼트안에 만든다.

w 와 h 속성은 선택적이며, 속성이 생략되면 컨테이너 엘리먼트의 크기에 맞춰서 채운다.

## 레이어 등록하기
Stage 안에서 사용될 레이어를 등록해야 Stage내에서 생성할 수 있다.

```
stage.register('widget-layer', things.layer.WidgetLayer);
stage.register('debug-layer', things.layer.DebugLayer);
stage.register('slide-layer', things.layer.SlideLayer);
stage.register('selection-layer', things.layer.SelectionLayer);
stage.register('magnify-layer', things.layer.MagnifyLayer);
stage.register('ruler-layer', things.layer.RulerLayer);
```

위의 예시는 Stage안에서 여섯가지 레이어를 사용하기 위해서 미리 등록하는 예시이다.
register 메쏘드에는 레이어 타입명과 레이어 클래스를 명시해준다.
레이어 타입명은 레이어 클래스에 따라 고정되어있으며, 이 타입명을 임의로 바꿔서는 안된다. 그럼에도 레이어 타입명을 명시적으로 주는 이유는 레이어 configuration에서 사용되는 타입명이 어떤 레이어 클래스를 의미하는 지를 개발자가 이해하기 위해서이다.

## 레이어 추가하기
Stage안에 앞에서 등록된 레이어들을 추가하기 위해서는 Stage의 build 메쏘드를 사용한다.

```
stage.build({
    type: 'widget-layer'
});

stage.build({
    type: 'ruler-layer',
    config: {
        'target': 'widget-layer'
    }
});

stage.build({
    type: 'selection-layer',
    config: {
        'target': 'widget-layer'
    }
});

stage.build({
    type: 'magnify-layer',
    config: {
        'target': 'widget-layer',
        'fillStyle': 'white',
        'strokeStyle': 'gray',
        'r': 100,
        'ratio': 2
    }
});

stage.build({
    type: 'slide-layer',
    config: {
        'target': 'widget-layer'
    }
});

stage.build({
    type: 'debug-layer'
});
```

각 레이어는 레이어의 타입명과 configuration정보를 오브젝트 형태로 정의한다.
build 메쏘드에는 레이어를 정의한 오브젝트나 오브젝트들의 배열로 추가하고자 하는 레이어 정보를 제공할 수 있다.

## 모델 추가하기
필요한 레이어를 추가한 후에는 Stage에서 표현하고자하는 대상(모델)에 대한 정보를 지정할 수 있다. (지정하지 않으면, 빈 모델이 사용된다.)
Stage에서 모델을 지정하면, 각 레이어는 필요한 경우 모델 정보를 참조하여 각자의 역할을 수행한다.

Stage에서 모델을 지정하기 위해서 model 메쏘드를 사용한다.

모델정보는 컨테이너/컴포넌트 구조에 맞춰서 (각 컴포넌트의 타입과 configuration 정보가 포함된) 오브젝트의 배열을 components 속성으로 갖는 오브젝트로 만들어진다.

```
var widgets = [{
  type: 'rect',
  config: {
    x: 100,
    y: 100,
    w: 200,
    h: 200,
    strokeStyle: 'black',
    fillStyle: 'white',
    lineWidth: 7,
    rotate: 30,
    draggable: true
  }
}, {
  type: 'line',
  config: {
    x1: 500,
    y1: 100,
    x2: 600,
    y2: 300,
    lineWidth: 10,
    strokeStyle: 'gray',
    draggable: true
  }
}, {
  type: 'circle',
  config: {
    cx: 350,
    cy: 150,
    r: 100,
    strokeStyle: 'yellow',
    fillStyle: 'green',
    lineWidth: 5,
    draggable: true
  }
}, {
  type: 'ellipse',
  config: {
    x: 400,
    y: 250,
    w: 200,
    h: 100,
    draggable: true,
    strokeStyle: 'green',
    fillStyle: 'lightgray',
    lineWidth: 1,
    rotate: 15,
    draggable: true
  }
}, {
  type: 'image',
  config: {
    x: 400,
    y: 200,
    rotate: -15,
    strokeStyle: 'yellow',
    fillStyle: 'green',
    lineWidth: 5,
    src: 'http://www.html5canvastutorials.com/demos/assets/darth-vader.jpg',
    draggable: true
  }
}, {
  type: 'barcode',
  config: {
    id: 'barcode001',
    x: 100,
    y: 400,
    strokeStyle: 'navy',
    fillStyle: 'green',
    lineWidth: 5,
    symbol: 'qrcode',
    text: 'http://www.html5canvastutorials.com/demos/assets/darth-vader.jpg',
    'scale-w': 4,
    'scale-h': 4,
    draggable: true
  }
}, {
  type: 'path',
  config: {
    path: [[100, 400], [200, 300], [300, 500], [350, 350]],
    strokeStyle: 'blue',
    lineWidth: 10,
    margin: [10, 10],
    draggable: true
  }
}];

stage.model({
    dependencies: {
        'group': things.group.Group,
        'rect': things.shape.Rect,
        'line': things.shape.Line,
        'path': things.shape.Path,
        'circle': things.shape.Circle,
        'ellipse': things.shape.Ellipse,
        'ruler': things.shape.Ruler,
        'image': things.shape.ImageBox,
        'barcode': things.shape.Barcode
    },
    components: widgets
});
```
모델정보를 설정하면서 모델정보안에서 사용된 컴포넌트들에 대한 등록정보는 앞에서 레이어를 등록하는 방법처럼 register메쏘드를 사용할 수도 있고, model 정보내에 dependencies 속성으로 등록할 수도 있다.

모델 정보까지 설정하면, 지정한 div 컨테이너안에 Stage가 모델 정보를 렌더링 하는 것을 확인할 수 있을 것이다.
