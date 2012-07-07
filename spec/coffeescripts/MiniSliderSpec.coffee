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
      describe 'containerClass', ->
        it 'should wrapp the slider in a div with the css class slider-container by default', ->
          new $.miniSlider( @$element )

          $wrapper = @$element
          expect( $wrapper.prop( 'tagName' ) ).toBe 'DIV'
          expect( @$element.parent() ).toHaveClass 'slider-container'

        it 'should wrapp the slider in a div with a custom css class when specified', ->
          new $.miniSlider( @$element, { containerClass: 'custom-class' } )

          $wrapper = @$element
          expect( $wrapper.prop( 'tagName' ) ).toBe 'DIV'
          expect( @$element.parent() ).toHaveClass 'custom-class'


      describe 'currentClass', ->
        it 'should add the css class "current" to the first element by default', ->
          new $.miniSlider( @$element )

          expect( @$element.children('.current').length ).toBe 1
          expect( @$element.children().first() ).toHaveClass 'current'


        it 'should add a custom css clas to the first element when specified', ->
          new $.miniSlider( @$element, currentClass: 'custom-class'  )

          expect( @$element.children('.custom-class').length ).toBe 1
          expect( @$element.children().first() ).toHaveClass 'custom-class'

      describe 'previousClass', ->
        it 'should add the css class "previous" to the last element by default', ->
          new $.miniSlider( @$element )

          expect( @$element.children('.previous').length ).toBe 1
          expect( @$element.children().last() ).toHaveClass 'previous'


        it 'should add a custom css clas to the last element when specified', ->
          new $.miniSlider( @$element, previousClass: 'custom-class'  )

          expect( @$element.children('.custom-class').length ).toBe 1
          expect( @$element.children().last() ).toHaveClass 'custom-class'

      describe 'nextClass', ->
        it 'should add the css class "next" to the second element by default', ->
          new $.miniSlider( @$element )

          expect( @$element.children('.next').length ).toBe 1
          expect( @$element.children()[1] ).toHaveClass 'next'


        it 'should add a custom css clas to the second element when specified', ->
          new $.miniSlider( @$element, nextClass: 'custom-class'  )

          expect( @$element.children('.custom-class').length ).toBe 1
          expect( @$element.children()[1] ).toHaveClass 'custom-class'

      describe 'navigation', ->
        describe 'showNavigation', ->
          it 'should generate the navigation by default', ->
            new $.miniSlider( @$element )            

            expect( $( 'a.previous-btn' ) ).toExist()
            expect( $( 'a.next-btn' ) ).toExist()

          it 'should not generate the naviation is showNavigation is set to false', ->
            new $.miniSlider( @$element, { showNavigation: false } )            

            expect( $( 'a.previous-btn' ) ).not.toExist()
            expect( $( 'a.next-btn' ) ).not.toExist()

        describe 'previousBtnClass', ->
          it 'should add the css class previous-btn to the previous button by default', ->
            new $.miniSlider( @$element )            

            expect( $( 'a.previous-btn' ) ).toExist()

          it 'should add the pevious button next to the slider container', ->
            new $.miniSlider( @$element )            

            expect( $( '.slider-container' ).next() ).toHaveClass 'previous-btn'

          it 'should add a custom css button to the previous button when specified', ->
            new $.miniSlider( @$element, previousBtnClass: 'custom-class' )            

            expect( $('a.previous-btn') ).not.toExist()
            expect( $( 'a.custom-class' ) ).toExist()

        describe 'nextBtnClass', ->
          it 'should add the css class next-btn to the next button by default', ->
            new $.miniSlider( @$element )            

            expect( $( 'a.next-btn' ) ).toExist()

          it 'should add the next button next to the preious button', ->
            new $.miniSlider( @$element )            

            expect( $( 'a.previous-btn' ).next() ).toHaveClass 'next-btn'

          it 'should add a custom css button to the next button when specified', ->
            new $.miniSlider( @$element, nextBtnClass: 'custom-class' )            

            expect( $('a.next-btn') ).not.toExist()
            expect( $( 'a.custom-class' ) ).toExist()

        describe 'previousBtnContent', ->
          it 'should add the left arrow as previous button content by default', ->
            new $.miniSlider( @$element )

            expect( $('a.previous-btn') ).toHaveText '‹'

          it 'should add a custom text as previous button content when specified', ->
            new $.miniSlider( @$element, { previousBtnContent: 'custom text' } )

            expect( $('a.previous-btn') ).toHaveText 'custom text'

        describe 'nextBtnContent', ->
          it 'should add the right arrow as next button content by default', ->
            new $.miniSlider( @$element )

            expect( $('a.next-btn') ).toHaveText '›'

          it 'should add a custom text as previous button content when specified', ->
            new $.miniSlider( @$element, { nextBtnContent: 'some text'} )

            expect( $('a.next-btn') ).toHaveText 'some text'

      describe 'pagination', ->
        describe 'showPagination', ->
          it 'should show the pagination by default', ->
            new $.miniSlider( @$element )

            expect( $( 'ul.pagination' ) ).toExist()

          it 'should be added next to the next button', ->            
            new $.miniSlider( @$element )

            expect( $( '.next-btn' ).next() ).toHaveClass( 'pagination' )

          it 'should have as many list items as slides', ->
            new $.miniSlider( @$element )

            expect( $( 'ul.pagination > li' ).length ).toBe @$element.children().length

          it 'should not show the pagination when showPagination is false', ->         
            new $.miniSlider( @$element, { showPagination: false } )

            expect( $( 'ul.pagination' ) ).not.toExist()


        describe 'paginationClass', ->
          it 'should add the css class "pagination" to the pagination by default', ->
            new $.miniSlider( @$element )

            expect( $( 'ul.pagination' ) ).toExist()

          it 'should add a custom css class to the pagination ul when specified', ->
            new $.miniSlider( @$element, { paginationClass: 'custom-class' } )

            expect( $( 'ul.pagination' ) ).not.toExist()
            expect( $( 'ul.custom-class' ) ).toExist()

        describe 'currentPaginationClass', ->
          it 'should add the default current pagination class to the first pagination item by default', ->
            new $.miniSlider( @$element )

            expect( $( 'ul.pagination > li' ).first() ).toHaveClass 'current-pagination'

          it 'should add a custom current pagination class to the first pagination item when specified', ->
            new $.miniSlider( @$element, { currentPaginationClass: 'custom-class'} )

            expect( $( 'ul.pagination > li' ).first() ).toHaveClass 'custom-class'

    describe 'animation', ->
      # delay
      # authoplay
      # transitionSpeed
      # transitionEasing
      # puseOnHover

    describe 'navigation', ->
      # currentClass
      # previousClass
      # nextClass
      # next / previous links
      # pagination

    describe 'callbacks', ->
      beforeEach ->
        @callback = jasmine.createSpy 'callback'

      # onLoad
      # onReady
      # onTransition
      # onComplete



      

