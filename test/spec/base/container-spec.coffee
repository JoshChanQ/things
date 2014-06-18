define [
  '../../../scripts/base/Component',
  '../../../scripts/base/Container',
  '../../../scripts/base/ComponentSelector'
], (
  Component,
  Container,
  ComponentSelector
) ->

  describe 'Container', ->
    describe 'core mixins', ->
      it 'should have functions supported by dou core mixins', ->

        inst = new Container

        inst.set.should.be.a 'function'
        inst.serialize.should.be.a 'function'

      it 'should contain components as a children', ->
        inst = new Container

        inst.add new Component

        inst.size().should.equal 1

    describe 'initialize', ->

      it 'should make components container for the mixined object', ->

        inst = new Container

        inst.add('a')

        inst.size().should.equal(1)

    describe 'add', ->

      it 'should be able to accept a component or a array of components', ->

        inst = new Container()

        inst.add('a')
        inst.add(['b', 'c', 'd'])

        inst.size().should.equal(4)
        inst.getAt(3).should.equal('d')

      it 'should make container to be a event delegator for component', ->

        container = new Container('for_add_container')
        component = new Component('for_add_component')

        component_added_event_occurred = 0
        container_add_event_occurred = 0
        delegated_added_event_occurred = 0

        component.on 'all', (e) ->
          event = arguments[arguments.length - 1].name

          switch(event)
            when 'added' then component_added_event_occurred++

        container.on 'all', (e) ->
          event = arguments[arguments.length - 1].name

          switch(event)
            when 'add' then container_add_event_occurred++
            when 'added' then delegated_added_event_occurred++

        container.add(component)

        component_added_event_occurred.should.equal(1)
        container_add_event_occurred.should.equal(1)
        delegated_added_event_occurred.should.equal(1)

    describe 'remove', ->

      it 'should be able to accept a child or array of children', ->

        inst = new Container()

        inst.initialize({})

        inst.add(['a', 'b', 'c', 'd', 'e'])
        inst.remove(['b', 'c', 'd'])

        inst.size().should.equal(2)
        inst.getAt(1).should.equal('e')

      it 'should remove event delegation relation', ->

        root = new Container('root')
        folder = new Container('folder')
        file = new Component('file')

        root.add(folder)

        root_event_count = 0
        file_event_count = 0
        delegated_event_count = 0

        file.on 'all', (e) ->
          event = arguments[arguments.length - 1].name
          switch(event)
            when 'added' then file_event_count++
            when 'removed' then file_event_count--

        root.on 'all', (e) ->
          event = arguments[arguments.length - 1].name
          switch(event)
            when 'add' then root_event_count++
            when 'remove' then root_event_count--
            when 'added' then delegated_event_count++
            when 'removed' then delegated_event_count--

        folder.add(file)

        file_event_count.should.equal(1)
        root_event_count.should.equal(1)
        delegated_event_count.should.equal(1)

        folder.remove(file)

        file_event_count.should.equal(0)
        root_event_count.should.equal(0)
        delegated_event_count.should.equal(0)

        # check folder to be removed as a event delegator for the removed file
        file.trigger('added', {})

        file_event_count.should.equal(1)
        root_event_count.should.equal(0)
        delegated_event_count.should.equal(0)

        file.trigger('removed', {})

        file_event_count.should.equal(0)
        root_event_count.should.equal(0)
        delegated_event_count.should.equal(0)

    describe 'forEach', ->

      it 'should execute function based on the specified context for all items', ->

        inst = new Container()

        inst.initialize({})

        inst.add(['a', 'b', 'c', 'd', 'e'])

        context =
          join : ''

        inst.forEach (i) ->
          this.join += i
        , context

        context.join.should.be.equal('abcde')

    describe 'moveChildBackward', ->
      it 'should exchange positions of the child and the precedence each other', ->
        inst = new Container

        inst.initialize({})

        inst.add([1, 2, 3, 4])

        inst.moveChildBackward(2)
        expect(inst.indexOf(2)).to.equal(0)
        expect(inst.indexOf(1)).to.equal(1)

        inst.moveChildBackward(2)
        expect(inst.indexOf(2)).to.equal(0)

    describe 'moveChildForward', ->
      it 'should exchange positions of the child and the following each other', ->
        inst = new Container

        inst.initialize({})

        inst.add([1, 2, 3, 4])

        inst.moveChildForward(2)
        expect(inst.indexOf(2)).to.equal(2)
        expect(inst.indexOf(3)).to.equal(1)

        inst.moveChildForward(4)
        expect(inst.indexOf(4)).to.equal(3)

    describe 'moveChildToBack', ->
      it 'should move the child to the top of the list', ->
        inst = new Container()

        inst.initialize({})

        inst.add([1, 2, 3, 4])

        inst.moveChildToBack(1)
        expect(inst.indexOf(1)).to.equal(0)

        inst.moveChildToBack(3)
        expect(inst.indexOf(3)).to.equal(0)
        expect(inst.indexOf(1)).to.equal(1)

    describe 'moveChildToFront', ->
      it 'should move the child to the end of the list', ->
        inst = new Container()

        inst.initialize({})

        inst.add([1, 2, 3, 4])

        inst.moveChildToFront(4)
        expect(inst.indexOf(4)).to.equal(3)

        inst.moveChildToFront(1)
        expect(inst.indexOf(1)).to.equal(3)
        expect(inst.indexOf(4)).to.equal(2)

    describe 'moveChildAt', ->
      it 'should move the child to the index of the list', ->
        inst = new Container()

        inst.initialize({})

        inst.add([1, 2, 3, 4])

        inst.moveChildAt(1, 4)
        expect(inst.indexOf(4)).to.equal(1)

        inst.moveChildAt(3, 4)
        expect(inst.indexOf(4)).to.equal(3)

