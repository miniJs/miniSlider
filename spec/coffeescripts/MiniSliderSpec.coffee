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

    describe 'initialization', ->
      # containerClass
      # currentClass
      # previousClass
      # nextClass


    describe 'animation', ->
      # delay
      # authoplay
      # transitionSpeed
      # transitionEasing

    describe 'navigation', ->
      # puseOnHover
      # showNavigation
      # previousBtnClass
      # nextBtnClass
      # previousBtnContent
      # nextBtnContent
      # showPagination
      # paginationClass
      # currentPaginationClass

    describe 'callbacks', ->
      beforeEach ->
        @callback = jasmine.createSpy 'callback'

      # onLoad
      # onReady
      # onTransition
      # onComplete



      

