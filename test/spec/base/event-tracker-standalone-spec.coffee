define [
  '../../../scripts/base/Module'
  '../../../scripts/base/Event'
  '../../../scripts/base/EventTracker'
], (
  Module
  Event
  EventTracker
) ->

  describe 'EventTracker.StandAlone', ->

    describe 'on/off', ->
      class EventSource extends Module
        @include Event
        test: (e) ->
          this.trigger('dragstart', e)
          for i in [0..9]
            this.trigger('dragmove', e)
          this.trigger('dragend', e)
        twice: (num) ->
          return num * 2

      evsource = null

      beforeEach ->
        evsource = new EventSource()

      it 'should execute belonging event handlers on the bound events', ->
        startcount = 0
        movecount = 0
        endcount = 0

        tracker = new EventTracker.StandAlone evsource,
          dragstart: (e) ->
            startcount++
          dragmove: (e) ->
            movecount++
          dragend: (e) ->
            endcount++

        tracker.on()
        evsource.test()

        startcount.should.equal(1)
        movecount.should.equal(10)
        endcount.should.equal(1)

        tracker.off()

        tracker.on()
        evsource.test()

        startcount.should.equal(2)
        movecount.should.equal(20)
        endcount.should.equal(2)

        tracker.dispose()

      it 'should bind on the specified object when handlers call-backed', ->
        self =
          a: 'a'

        tracker = new EventTracker.StandAlone evsource,
          dragstart: (e) ->
            this.a = 'A'
        , self

        tracker.on()
        evsource.test()

        self.a.should.equal('A')

        tracker.dispose()

      it 'should bind target object when handlers call-backed if bind object is not specified', ->
        calc = 1

        tracker = new EventTracker.StandAlone evsource,
          dragstart: (e) ->
            calc = this.twice(calc)

        tracker.on()
        evsource.test()

        calc.should.equal(2)

        tracker.dispose()
