define [
  '../../scripts/base/UserEventEngine'
], (
  UserEventEngine
) ->

  describe 'UserEventEngine', ->
    describe '#append()', ->
      it 'should attach only layer(s) to the context', ->
        1.should.be.truthy
