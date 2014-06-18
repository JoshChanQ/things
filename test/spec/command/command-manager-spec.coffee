define [
  '../../../scripts/command/Command'
  '../../../scripts/command/CommandManager'
], (
  Command
  CommandManager
) ->

  describe 'CommandManager', ->
    cm = null

    count = 0

    class SampleCommand extends Command
      execute: ->
        count++
      unexecute: ->
        count--

    beforeEach ->
      cm = new CommandManager()
      count = 0

    describe 'execute', ->

      it 'should execute command through CommandManager', ->
        cm.execute(new SampleCommand())

        count.should.equal(1)

    describe 'undo', ->

      it 'should execute reverse actions of the queued command', ->
        cm.execute(new SampleCommand())

        cm.undo()
        count.should.equal(0)

    describe 'redo', ->

      it 'should execute actions of the undoed command', ->
        cm.execute(new SampleCommand())

        cm.undo()
        count.should.equal(0)

        cm.redo()
        count.should.equal(1)

    describe 'reset', ->

      it 'should make undoable to false', ->
        cm.execute(new SampleCommand())

        cm.undo()
        count.should.equal(0)

        cm.redo()
        cm.undoable().should.equal(true)

        cm.reset()
        cm.undoable().should.equal(false)

      it 'should make redoable to false', ->
        cm.execute(new SampleCommand())

        cm.undo()
        count.should.equal(0)

        cm.redoable().should.equal(true)

        cm.reset()
        cm.redoable().should.equal(false)

