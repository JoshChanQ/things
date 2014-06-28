define [
  '../../scripts/things',
  '../../scripts/plugin/stage/WidgetBox'
  '../../scripts/plugin/group/Group'
  '../../scripts/plugin/shape/Rect'
  '../../scripts/plugin/shape/Line'
  '../../scripts/plugin/shape/Circle'
  '../../scripts/plugin/shape/Ellipse'
  '../../scripts/plugin/shape/Ruler'
  '../../scripts/plugin/shape/ImageBox'
  '../../scripts/plugin/shape/Barcode'
  'jquery'
], (
  things,
  WidgetBox
  Group
  Rect
  Line
  Circle
  Ellipse
  Ruler
  ImageBox
  Barcode
  $
) ->

  describe 'things', ->
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
            attrs:
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
            attrs:
              x1: 500
              y1: 100
              x2: 600
              y2: 300
              lineWidth: 10
              strokeStyle: 'gray'
              draggable: true

          widgets.push
            type: 'circle'
            attrs:
              cx: 350
              cy: 150
              r: 100
              strokeStyle: 'yellow'
              fillStyle: 'green'
              lineWidth: 5
              draggable: true

          widgets.push
            type: 'ellipse'
            attrs:
              x: 400
              y: 250
              w: 200
              h: 100
              draggable: true
              strokeStyle: 'green'
              fillStyle: 'lightgray'
              lineWidth: 1
              rotate: 15
              draggable: true

          widgets.push
            type: 'image'
            attrs:
              x: 400
              y: 100
              w: 400
              h: 400
              strokeStyle: 'yellow'
              fillStyle: 'green'
              lineWidth: 5
              src: 'http://www.html5canvastutorials.com/demos/assets/darth-vader.jpg'
              draggable: true

          widgets.push
            type: 'barcode'
            attrs:
              x: 200
              y: 100
              w: 400
              h: 400
              strokeStyle: 'navy'
              fillStyle: 'green'
              lineWidth: 5
              symbol: 'qrcode'
              text: 'http://www.html5canvastutorials.com/demos/assets/darth-vader.jpg'
              'scale-w': 4
              'scale-h': 4
              draggable: true

          widgets.push
            type: 'ruler'
            attrs:
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
            attrs:
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

        widgets.push
          type: 'group'
          attrs:
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
            attrs:
              x: 50
              y: 50
              w: 100
              h: 100
              strokeStyle: 'black'
              fillStyle: 'orange'
              draggable: true
          }, {
            type: 'circle'
            attrs:
              cx: 200
              cy: 200
              r: 50
              strokeStyle: 'black'
              fillStyle: 'orange'
              draggable: true
          }, {
            type: 'line'
            attrs:
              x1: 280
              y1: 50
              x2: 280
              y2: 250
              strokeStyle: 'black'
              fillStyle: 'orange'
              draggable: true
          }]

        thing = things.create
          dependencies:
            'widget-box': WidgetBox
            'group': Group
            'rect': Rect
            'line': Line
            'circle': Circle
            'ellipse': Ellipse
            'ruler': Ruler
            'image': ImageBox
            'barcode': Barcode
          type: 'widget-box'
          attrs:
            container: 'container'
            w: 800
            h: 500
          widgets: widgets

        # $(html_container).children().get(0).tagName.should.equal 'CANVAS'
        # console.log thing
        # thing.controller.componentRegistry.list().length.should.equal 5
        things.stages().length.should.equal 1
