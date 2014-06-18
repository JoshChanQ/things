define [
  '../../scripts/Template'
], (
  Template
) ->

  describe 'Template', ->
    describe '#append()', ->
      it 'should attach only layer(s) to the context', ->
        1.should.be.truthy
