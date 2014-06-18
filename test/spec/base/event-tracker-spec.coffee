define [
  '../../../scripts/base/Module'
  '../../../scripts/base/Event'
  '../../../scripts/base/EventTracker'
], (
  Module
  Event
  EventTracker
) ->

  describe 'EventTracker', ->

    eventTracker = null

    class EventSource extends Module
      @include Event
      test: (e) ->
        this.trigger('dragstart', e)

        for i in [0..9]
          this.trigger('dragmove', e)

        this.trigger('dragend', e)
      twice: (num) ->
        num * 2

    evsource = null

    beforeEach ->
      evsource = new EventSource()
      eventTracker = new EventTracker()

    afterEach ->
      eventTracker.dispose()

    describe 'on', ->
      it 'should execute belonging event handlers on the bound events', ->
        startcount = 0
        movecount = 0
        endcount = 0

        handlers =
          dragstart: (e) ->
            startcount++
          dragmove: (e) ->
            movecount++
          dragend: (e) ->
            endcount++

        eventTracker.on(evsource, handlers)
        evsource.test()

        startcount.should.equal(1)
        movecount.should.equal(10)
        endcount.should.equal(1)

        eventTracker.off(evsource, handlers)

        eventTracker.on(evsource, handlers)
        evsource.test()

        startcount.should.equal(2)
        movecount.should.equal(20)
        endcount.should.equal(2)

      it 'should bind on the specified object self when handlers call-backed', ->
        self =
          a: 'a'

        handlers =
          dragstart: (e) ->
            this.context.a = 'A'

        eventTracker.on(evsource, handlers, {}, self)
        evsource.test()

        self.a.should.equal('A')

      it 'should bind target object self member when handlers call-backed if bind object is not specified', ->
        calc = 1

        handlers =
          dragstart: (e) ->
            calc = this.context.twice(calc)

        eventTracker.on(evsource, handlers)
        evsource.test()

        calc.should.equal(2)

      it 'should recognize (self) selector', ->
        eventTracker.setSelector
          select: (selector, listener) ->
            return listener if selector == '(self)'

        count = 0

        handlers =
          dragstart: (e) ->
            count++

        eventTracker.on('(self)', handlers, evsource)
        evsource.test()

        count.should.equal(1)

    describe 'off', ->
      it 'should remove managed tracker which is matched with target object and handlers', ->
        handlers1 =
          dragstart: (e) ->
          dragmove: (e) ->
          dragend: (e) ->

        handlers2 =
          dragstart: (e) ->
          dragmove: (e) ->
          dragend: (e) ->

        trackers = eventTracker.all()
        trackers.length.should.equal(0)

        eventTracker.on(evsource, handlers1)
        eventTracker.on(evsource, handlers2)
        trackers = eventTracker.all()
        trackers.length.should.equal(2)

        eventTracker.off(evsource, handlers1)
        trackers = eventTracker.all()
        trackers.length.should.equal(1)

      it 'should match with only target object when handlers is not specified', ->
        handlers1 =
          dragstart: (e) ->
          dragmove: (e) ->
          dragend: (e) ->

        handlers2 =
          dragstart: (e) ->
          dragmove: (e) ->
          dragend: (e) ->

        trackers = eventTracker.all()
        trackers.length.should.equal(0)

        eventTracker.on(evsource, handlers1)
        eventTracker.on(evsource, handlers2)
        trackers = eventTracker.all()
        trackers.length.should.equal(2)

        eventTracker.off(evsource)
        trackers = eventTracker.all()
        trackers.length.should.equal(0)
