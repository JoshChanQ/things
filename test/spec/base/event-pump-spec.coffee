define [
  '../../../scripts/base/Component'
  '../../../scripts/base/Container'
  '../../../scripts/base/EventPump'
], (
  Component
  Container
  EventPump
) ->

  describe 'EventPump', ->

    root = null

    computer = null

    folder1 = null
    folder2 = null
    folder3 = null

    folder11 = null

    file111 = null
    file112 = null
    file113 = null
    link114 = null

    file21 = null
    link22 = null

    file31 = null
    link32 = null

    origin_computer_count = null
    origin_folder_count = null
    origin_file_count = null
    origin_link_count = null

    deliverer_computer_count = null
    deliverer_folder_count = null
    deliverer_file_count = null
    deliverer_link_count = null

    beforeEach ->
      origin_computer_count = 0
      origin_folder_count = 0
      origin_file_count = 0
      origin_link_count = 0

      deliverer_computer_count = 0
      deliverer_folder_count = 0
      deliverer_file_count = 0
      deliverer_link_count = 0

      root = computer = new Container('computer')
      computer.initialize({id: 'computer1'})

      folder1 = new Container('folder')
      folder1.initialize({id: 'folder1'})
      folder2 = new Container('folder')
      folder2.initialize({id: 'folder2'})
      folder3 = new Container('folder')
      folder3.initialize({id: 'folder3'})

      root.add([folder1, folder2, folder3])

      folder11 = new Container('folder')
      folder11.initialize({id: 'folder11'})

      folder1.add(folder11)

      file111 = new Component('file')
      file111.initialize({id: 'file111'})
      file112 = new Component('file')
      file112.initialize({id: 'file112'})
      file113 = new Component('file')
      file113.initialize({id: 'file113'})
      link114 = new Component('link')
      link114.initialize({id: 'link114'})

      folder11.add([file111, file112, file113, link114])

      file21 = new Component('file')
      file21.initialize({id: 'file21'})
      link22 = new Component('link')
      link22.initialize({id: 'link22'})

      folder2.add([file21, link22])

      file31 = new Component('file')
      file31.initialize({id: 'file31'})
      link32 = new Component('link')
      link32.initialize({id: 'link32q'})

      folder3.add([file31, link32])

    afterEach ->
      root.dispose()

    describe 'on/off', ->

      it 'should be able to use id, type and special(self, all) selector', ->

        listener = {}

        handler = (e) ->
          eval("origin_" + e.origin.type + "_count++")
          eval("deliverer_" + e.deliverer.type + "_count++")

          listener_count = listener[e.listener.get('id')]
          listener[e.listener.get('id')] = if listener_count then ++listener_count else 1

        computer_listener =
          '(self)':
            'event': handler
          '#file111':
            'event': handler

        pump = new EventPump(computer)

        pump.on(computer, computer_listener)

        folder_listener =
          '(self)':
            'event': handler
          '#link114':
            'event': handler

        pump.on(folder1, folder_listener)

        pump.start()

        file111.trigger('event')
        computer.trigger('event')

        link114.trigger('event')
        folder1.trigger('event')

        listener['computer1'].should.exist
        listener['computer1'].should.be.equal(2)
        listener['folder1'].should.be.equal(2)

        origin_computer_count.should.be.equal(1)
        origin_file_count.should.be.equal(1)
        origin_folder_count.should.be.equal(1)
        origin_link_count.should.be.equal(1)

        deliverer_computer_count.should.be.equal(4)

        # Remove Subscriber

        pump.off(folder1)

        file111.trigger('event')
        computer.trigger('event')

        link114.trigger('event')
        folder1.trigger('event')

        listener['computer1'].should.be.equal(4)
        listener['folder1'].should.be.equal(2)

        origin_computer_count.should.be.equal(2)
        origin_file_count.should.be.equal(2)
        origin_folder_count.should.be.equal(1)
        origin_link_count.should.be.equal(1)

        deliverer_computer_count.should.be.equal(6)

        pump.dispose()

      it 'should be able to use variable selector', ->

        file_count = 0
        link_count = 0

        handler1 = (e) ->
          file_count++

        handler2 = (e) ->
          link_count++

        computer.set('var1', '#file31')
        computer.set('var2', '#link22')

        computer_listener =
          '?var1':
            'event': handler1
          '?var2':
            'event': handler2

        pump = new EventPump(computer)
        pump.start()

        pump.on(computer, computer_listener)

        file31.trigger('event')
        link22.trigger('event')

        file_count.should.be.equal(1)
        link_count.should.be.equal(1)


      it('should call handlers with context')
      it('should recognize synonyms with parenthesys')
