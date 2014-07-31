define [
  '../../scripts/things',
], (
  things,
) ->

  this.things = things

  describe 'things-model', ->
    describe 'create', ->

      html_container = null
      thing = null

      beforeEach ->
        if(!html_container)
          html_container = document.createElement('div')
          html_container.setAttribute('id', 'container')
          document.body.appendChild(html_container)

      afterEach ->
        # thing.dispose()

      it 'should create canvas set under the html-container', ->
        widgets = []
        for i in [1..1]
          widgets.push
            type: 'rect'
            config:
              x: 100
              y: 100
              w: 200
              h: 200
              strokeStyle: 'black'
              fillStyle: 'white'
              lineWidth: 7
              rotate: 30
              draggable: true

          widgets.push
            type: 'line'
            config:
              x1: 500
              y1: 100
              x2: 600
              y2: 300
              lineWidth: 10
              strokeStyle: 'gray'
              draggable: true

          widgets.push
            type: 'circle'
            config:
              cx: 350
              cy: 150
              r: 100
              strokeStyle: 'yellow'
              fillStyle: 'green'
              lineWidth: 5
              draggable: true

          widgets.push
            type: 'ellipse'
            config:
              x: 400
              y: 250
              w: 200
              h: 100
              strokeStyle: 'green'
              fillStyle: 'lightgray'
              lineWidth: 1
              rotate: 15
              draggable: true

          widgets.push
            type: 'image'
            config:
              x: 400
              y: 200
              # w: 100
              # h: 100
              rotate: -15
              strokeStyle: 'yellow'
              fillStyle: 'green'
              lineWidth: 5
              src: 'http://www.html5canvastutorials.com/demos/assets/darth-vader1.jpg'
              draggable: true

          widgets.push
            type: 'barcode'
            config:
              id: 'barcode001'
              x: 100
              y: 400
              # w: 400
              # h: 400
              strokeStyle: 'navy'
              fillStyle: 'green'
              lineWidth: 5
              symbol: 'qrcode'
              text: 'http://www.html5canvastutorials.com/demos/assets/darth-vader.jpg'
              'scale-w': 4
              'scale-h': 4
              draggable: true
              resizable: true

          widgets.push
            type: 'ruler'
            config:
              x: 600
              y: 100
              w: 400
              h: 30
              strokeStyle: 'navy'
              # fillStyle: 'yellow'
              lineWidth: 1
              margin: [10, 10]
              zeropos: 0
              # rotate: 30x
              draggable: true

          widgets.push
            type: 'ruler'
            config:
              x: 600
              y: 100
              w: 30
              h: 400
              strokeStyle: 'blue'
              # fillStyle: 'yellow'
              lineWidth: 1
              margin: [10, 10]
              zeropos: 0
              direction: 'vertical'
              # rotate: 30
              draggable: true
              tag: ['vruler']

          widgets.push
            type: 'path'
            config:
              path: [[100, 400], [200, 300], [300, 500], [350, 350]]
              strokeStyle: 'blue'
              # fillStyle: 'yellow'
              lineWidth: 10
              margin: [10, 10]
              # rotate: 30
              draggable: true

        widgets.push
          type: 'group'
          config:
            x: 100
            y: 100
            w: 300
            h: 300
            rotate: 30
            draggable: true
            fillStyle: 'lightgray'
            strokeStyle: 'blue'
            lineWidth: 6
          components: [{
            type: 'rect'
            config:
              x: 50
              y: 50
              w: 100
              h: 100
              strokeStyle: 'black'
              fillStyle: 'orange'
              draggable: true
          }, {
            type: 'circle'
            config:
              cx: 200
              cy: 200
              r: 50
              strokeStyle: 'black'
              fillStyle: 'orange'
              draggable: true
          }, {
            type: 'line'
            config:
              x1: 280
              y1: 50
              x2: 280
              y2: 250
              strokeStyle: 'black'
              fillStyle: 'orange'
              draggable: true
          }]

        thing = things.create
          container: document.getElementById('container')
          h: 800

        thing.register 'widget-layer', things.layer.WidgetLayer
        thing.register 'debug-layer', things.layer.DebugLayer
        thing.register 'slide-layer', things.layer.SlideLayer
        thing.register 'selection-layer', things.layer.SelectionLayer
        thing.register 'magnify-layer', things.layer.MagnifyLayer
        thing.register 'ruler-layer', things.layer.RulerLayer

        thing.build
          type: 'widget-layer'

        thing.build
          type: 'ruler-layer'
          config:
            'target': 'widget-layer'

        thing.build
          type: 'selection-layer'
          config:
            'target': 'widget-layer'

        thing.build
          type: 'magnify-layer'
          config:
            'target': 'widget-layer'
            'fillStyle': 'white'
            'strokeStyle': 'gray'
            'r': 100
            'ratio': 2

        thing.build
          type: 'slide-layer'
          config:
            'target': 'widget-layer'

        thing.build
          type: 'debug-layer'

        thing.model
          dependencies:
            'group': things.group.Group
            'rect': things.shape.Rect
            'line': things.shape.Line
            'path': things.shape.Path
            'circle': things.shape.Circle
            'ellipse': things.shape.Ellipse
            'ruler': things.shape.Ruler
            'image': things.shape.ImageBox
            'barcode': things.shape.Barcode
          components: widgets

        thing.apply
          'line':
            'lineWidth': 100
          '.vruler':
            'strokeStyle': 'red'

        image = thing.select('image')[0]
        amplitude = 150
        centerX = 400
        period = 2000

        anim = new things.Animation (frame) ->
          image.set('x', amplitude * Math.sin(frame.time * 2 * Math.PI / period) + centerX)

        # anim.start()

        # layer = thing.select('widget-layer')[0]

        console.log 'serialize', thing.serialize()

        thing.set 'h', 600

        # $(html_container).children().get(0).tagName.should.equal 'CANVAS'
        # console.log thing
        # thing.controller.componentRegistry.list().length.should.equal 5
        things.stages().length.should.equal 1
