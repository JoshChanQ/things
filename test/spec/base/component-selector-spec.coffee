define [
  '../../../scripts/base/Component',
  '../../../scripts/base/Container',
  '../../../scripts/base/ComponentSelector'
], (
  Component,
  Container,
  ComponentSelector
) ->

  describe 'ComponentSelector', ->
    describe 'match', ->
      it 'should match selector with component type', ->
        component = new Component('sample')

        ComponentSelector.match('sample', component).should.be.true
        ComponentSelector.match('simple', component).should.be.false

    describe 'select', ->
      it 'should find components matched with selector', ->
        computer = new Container('computer')
          .initialize({id: 'id_computer', name: 'name_computer'})
        folder = new Container('folder')
          .initialize({id: 'id_folder', name: 'name_folder'})
        file1 = new Component('file')
          .initialize({id: 'id_file1', name: 'name_file1'})
        file2 = new Component('file')
          .initialize({id: 'id_file2', name: 'name_file2'})
        link = new Component('link')
          .initialize({id: 'id_link', name: 'name_link'})

        computer.add(folder)
        folder.add([file1, file2, link])

        ComponentSelector.select('file', computer)
          .should.have.members [file1, file2]
        ComponentSelector.select('#id_link', computer)
          .should.have.members [link]
        ComponentSelector.select('.name_folder', computer)
          .should.have.members [folder]
