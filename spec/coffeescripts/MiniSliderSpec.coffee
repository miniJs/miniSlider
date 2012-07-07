describe 'miniSlider', ->

  beforeEach ->
    loadFixtures 'fragment.html'
    @$element = $('#slider')

  describe 'plugin behaviour', ->
    it 'should be available on the jQuery object', ->
      expect( $.fn.miniSlider ).toBeDefined()

    it 'should be chainable', ->
      expect( @$element.miniSlider() ).toBe @$element

    it 'should offer default values', ->
      plugin = new $.miniSlider( @$element )

      expect( plugin.defaults ).toBeDefined()

    it 'should overwrite the settings', ->
      plugin = new $.miniSlider( @$element, { autoPlay: false, delay: 500 } )

      expect( plugin.settings.autoPlay ).toBeFalsy()
      expect( plugin.settings.delay ).toBe 500

