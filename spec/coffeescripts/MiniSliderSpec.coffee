describe 'miniSlider', ->
  sliderFixture = '<div id="slider">
                    <p>some text</p>
                    <p>some text</p>
                    <p>some text</p>
                    <p>some text</p>
                  </div>'

  beforeEach ->
    setFixtures sliderFixture
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
      beforeEach ->
        @clock = sinon.useFakeTimers()

      afterEach ->
        @clock.restore()  

      describe 'delay', ->
        it 'should apply a delay of 3000 between slides by default', ->
          spyOn( window, 'setInterval' )
          new $.miniSlider( @$element )

          expect( window.setInterval ).toHaveBeenCalledWith( jasmine.any( Function ), 3000 )

        it 'should apply a custom delay between slides when specified', ->
          spyOn( window, 'setInterval' )
          new $.miniSlider( @$element, { delay: 5000 } )

          expect( window.setInterval ).toHaveBeenCalledWith( jasmine.any( Function ), 5000 )

      describe 'autoPlay', ->
        it 'should autoplay the slider on load by default', ->
          plugin = new $.miniSlider( @$element )
          spyOn( plugin.slider, 'next' )
          
          @clock.tick 3000
          expect( plugin.slider.next ).toHaveBeenCalled()

        it 'should not autoplay the slider on load when autoPlay is false', ->
          plugin = new $.miniSlider( @$element, { autoPlay: false } )
          spyOn( plugin.slider, 'next' )
          
          @clock.tick 3000
          expect( plugin.slider.next ).not.toHaveBeenCalled()

      describe 'transitionSpeed', ->
        it 'should animate the slides for 500 milliseconds in between each other by default', ->
          plugin = new $.miniSlider( @$element )
          spyOn( plugin.slider.container, 'animate' )
          @clock.tick 3000

          expect( plugin.slider.container.animate ).toHaveBeenCalledWith( jasmine.any( Object ), 500, jasmine.any( String ), jasmine.any( Function ))

        it 'should animate the slides for a custom time when specified', ->
          plugin = new $.miniSlider( @$element, { transitionSpeed: 1000 } )
          spyOn( plugin.slider.container, 'animate' )
          @clock.tick 3000

          expect( plugin.slider.container.animate ).toHaveBeenCalledWith( jasmine.any( Object ), 1000, jasmine.any( String ), jasmine.any( Function ))
          
      describe 'transitionEasing', ->
        it 'should not use any easing equation when animating slides by default', ->
          plugin = new $.miniSlider( @$element )
          spyOn( plugin.slider.container, 'animate' )
          @clock.tick 3000

          expect( plugin.slider.container.animate ).toHaveBeenCalledWith( jasmine.any( Object ), jasmine.any( Number ), '', jasmine.any( Function ))

        it 'should use custom a easing equation when animating slides when specified', ->
          plugin = new $.miniSlider( @$element, transitionEasing: 'swing' )
          spyOn( plugin.slider.container, 'animate' )
          @clock.tick 3000

          expect( plugin.slider.container.animate ).toHaveBeenCalledWith( jasmine.any( Object ), jasmine.any( Number ), 'swing', jasmine.any( Function ))

      describe 'pauseOnHover', ->
        it 'should not pause the slider when hovering a slide by default', ->
          plugin = new $.miniSlider( @$element )
          spyOn( plugin.slider, 'pause' )

          plugin.slider.slides[0].element.trigger( 'mouseover' )
          expect( plugin.slider.pause ).not.toHaveBeenCalled()

        it 'should pause the slider when hovering a slide iff pauseOnHover is true', ->
          plugin = new $.miniSlider( @$element, { pauseOnHover: true } )
          spyOn( plugin.slider, 'pause' )

          plugin.slider.slides[0].element.trigger( 'mouseover' )
          expect( plugin.slider.pause ).toHaveBeenCalled()

        it 'should resume autoplay when hovering out a slide', ->
          plugin = new $.miniSlider( @$element, { pauseOnHover: true } )
          spyOn( plugin.slider, 'resume' )

          plugin.slider.slides[0].element.trigger( 'mouseover' ).trigger( 'mouseleave' )
          expect( plugin.slider.resume ).toHaveBeenCalled()

    describe 'navigation', ->
      # currentClass
      # previousClass
      # nextClass
      # next / previous links
      # pagination

    describe 'callbacks', ->
      beforeEach ->
        @callback = sinon.spy()
        @clock    = sinon.useFakeTimers()

      afterEach ->
        @callback.reset()
        @clock.restore()  

      it 'should call onLoad callback when slider is initializing', ->
        new $.miniSlider( @$element, { onLoad: @callback } )

        expect( @callback.calledWith() ).toBeTruthy()

      it 'should call onReady callback when slider is initializing', ->
        anotherCallback = sinon.spy()
        new $.miniSlider( @$element, { onLoad: @callback, onReady: anotherCallback } )

        expect( anotherCallback.calledWith() ).toBeTruthy()
        expect( anotherCallback.calledAfter( @callback ) ).toBeTruthy()

      it 'should call onTransition when are slides animating', ->
        plugin = new $.miniSlider( @$element, { onTransition: @callback, autoPlay: false, transitionSpeed: 0 } )          

        expect( @callback.called ).toBeFalsy()

        for index in [1..3]
          plugin.slider.next()
          expect( @callback.calledWith( plugin.slider.slides[index].element, index + 1 ) ).toBeTruthy()

        plugin.slider.next()
        expect( @callback.calledWith( plugin.slider.slides[0].element, 1 ) ).toBeTruthy()
      
      it 'should call onComplete callback when the animation is complete', ->
        plugin = new $.miniSlider( @$element, { onComplete: @callback, autoPlay: false } )

        expect( @callback.called ).toBeFalsy()
        plugin.slider.next()
        expect( @callback.called ).toBeFalsy()
        @clock.tick 600
        expect( @callback.called ).toBeTruthy()





      

