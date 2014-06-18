define [
  '../../scripts/things',
  '../../scripts/plugin/stage/WidgetBox'
  '../../scripts/plugin/group/Group'
  '../../scripts/plugin/widget/Rect'
  '../../scripts/plugin/widget/Line'
  '../../scripts/plugin/widget/Circle'
  '../../scripts/plugin/widget/Magnifier'
  'jquery'
], (
  things,
  WidgetBox
  Group
  Rect
  Line
  Circle
  Magnifier
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
        for i in [1..2]
          widgets.push
            type: 'rect'
            attrs:
              id: 'rect-' + i
              x: Math.random() * 600
              y: Math.random() * 300
              w: Math.random() * 200
              h: Math.random() * 200
              strokeStyle: 'black'
              fillStyle: 'white'
              lineWidth: 7
              draggable: true

          widgets.push
            type: 'line'
            attrs:
              id: 'line-' + i
              x1: Math.random() * 800
              y1: Math.random() * 500
              x2: Math.random() * 800
              y2: Math.random() * 500
              lineWidth: 10
              strokeStyle: 'gray'
              draggable: true

          widgets.push
            type: 'circle'
            attrs:
              id: 'circle-' + i
              cx: Math.random() * 600
              cy: Math.random() * 300
              r: Math.random() * 50
              strokeStyle: 'yellow'
              fillStyle: 'green'
              lineWidth: 5
              draggable: true

        widgets.push
          type: 'group'
          attrs:
            id: 'group-' + i
            x: 100
            y: 100
            w: 300
            h: 300
            draggable: true
            fillStyle: 'lightgray'
            strokeStyle: 'blue'
            lineWidth: 6
          components: [{
            type: 'rect'
            attrs:
              x: 200
              y: 200
              w: 100
              h: 100
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
            'magnifier': Magnifier
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
