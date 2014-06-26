define [
  '../../scripts/things',
  '../../scripts/plugin/stage/WidgetBox'
  '../../scripts/plugin/group/Group'
  '../../scripts/plugin/shape/Rect'
  '../../scripts/plugin/shape/Line'
  '../../scripts/plugin/shape/Circle'
  '../../scripts/plugin/shape/Ruler'
  'jquery'
], (
  things,
  WidgetBox
  Group
  Rect
  Line
  Circle
  Ruler
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
              # id: 'rect-' + i
              x: 100 #Math.round(Math.random() * 600)
              y: 100 #Math.round(Math.random() * 300)
              w: 200 #Math.round(Math.random() * 200)
              h: 200 #Math.round(Math.random() * 200)
              strokeStyle: 'black'
              fillStyle: 'white'
              lineWidth: 7
              rotate: 30
              draggable: true

          widgets.push
            type: 'line'
            attrs:
              # id: 'line-' + i
              x1: 500 #Math.round(Math.random() * 800)
              y1: 100 #Math.round(Math.random() * 500)
              x2: 600 #Math.round(Math.random() * 800)
              y2: 300 #Math.round(Math.random() * 500)
              lineWidth: 10
              strokeStyle: 'gray'
              draggable: true

          widgets.push
            type: 'circle'
            attrs:
              # id: 'circle-' + i
              cx: 350 #Math.round(Math.random() * 600)
              cy: 150 #Math.round(Math.random() * 300)
              r: 100 #Math.round(Math.random() * 50)
              strokeStyle: 'yellow'
              fillStyle: 'green'
              lineWidth: 5
              draggable: true

          widgets.push
            type: 'ruler'
            attrs:
              # id: 'rect-' + i
              x: 600 #Math.round(Math.random() * 600)
              y: 200 #Math.round(Math.random() * 300)
              w: 400 #Math.round(Math.random() * 200)
              h: 30 #Math.round(Math.random() * 200)
              strokeStyle: 'navy'
              # fillStyle: 'yellow'
              lineWidth: 1
              margin: [10, 10]
              zeropos: 0
              # rotate: 30
              draggable: true

          widgets.push
            type: 'ruler'
            attrs:
              # id: 'rect-' + i
              x: 600 #Math.round(Math.random() * 600)
              y: 200 #Math.round(Math.random() * 300)
              w: 30 #Math.round(Math.random() * 200)
              h: 400 #Math.round(Math.random() * 200)
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
            # id: 'group-' + i
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
            'ruler': Ruler
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
