#
# CoffeeScript jQuery Plugin Boilerplate
# By: Matthieu Aussaguel, http://www.mynameismatthieu.com, @mattaussaguel
# Version: 1.0 alpha 1.0
# Updated: February 21, 2012
#
class Slide
  constructor: (@element, @index, @options) ->
    @element.css { position: 'absolute', top: 0, left: @index * @element.width() }

class Slider
  constructor: (@container, @options) ->
    @state = 'waiting'

    @size = 
      height: @container.height()
      width: @container.width()

    @container.css({ overflow: 'hidden', position: 'absolute', top: 0, left: 0 })
              .wrap("<div class='#{@options.containerClass}' style='position: relative; overflow: hidden;'/>")
    @wrapper = @container.parent()

    @initSlides()
              
  appendNavigation: ->
    @wrapper.append(@previousLink())
            .append(@nextLink())

    @nextLink().on 'click', =>
      @stopAutoplay()
      @next()
      return false

    @previousLink().on 'click', =>
      @stopAutoplay()
      @previous()
      return false

  appendPagination: ->
    @wrapper.append(@pagination())

    @pagination().on 'click', 'a', (e) =>
      @to (($ e.currentTarget).attr('href').replace('#','') - 1)
      @stopAutoplay()
      return false

  previousLink: -> @$previousLink ||= $('<a />', { html: @options.previousBtnContent, class: @options.previousBtnClass, href: '#' })
  
  nextLink: -> @$nextLink ||= $('<a />', { html: @options.nextBtnContent, class: @options.nextBtnClass, href: '#' })

  pagination: ->
    unless @$pagination
      @$pagination = $('<ul />', class: @options.paginationClass)
      @$pagination.append("<li><a href='##{index + 1}'>#{index + 1}</li>") for slide, index in @slides

    @$pagination

  currentPaginationElement: -> @pagination().find("li:eq(#{@currentIndex})")

  count: -> @slides.length

  initSlides: ->
    # Create array of slide objects
    @slides = []
    @container.children().each (index, element) =>  @slides.push(new Slide(($ element), index, @options))  

    @container.css('width', @size.width * @slides.length)
    @initTracker()

  currentSlideElement: -> @slides[@currentIndex].element

  previousSlideElement: -> @slides[@previousIndex].element

  nextSlideElement: -> @slides[@nextIndex].element

  initTracker: -> 
    @currentIndex = 0
    @previousIndex = @count() - 1
    @nextIndex = 1

    @addCssClasses()    

  updateTracker: (newIndex) ->
    @removeCssClasses()    

    @currentIndex  = newIndex
    @previousIndex = if newIndex is 0 then @count() - 1 else newIndex - 1
    @nextIndex     = if newIndex is @count() - 1 then 0 else newIndex + 1

    @addCssClasses()    

  addCssClasses: ->
    @currentSlideElement().addClass @options.currentClass
    @previousSlideElement().addClass @options.previousClass
    @nextSlideElement().addClass @options.nextClass

    @currentPaginationElement().addClass(@options.currentPaginationClass)

  removeCssClasses: ->
    @currentSlideElement().removeClass @options.currentClass
    @previousSlideElement().removeClass @options.previousClass
    @nextSlideElement().removeClass @options.nextClass

    @currentPaginationElement().removeClass(@options.currentPaginationClass)

  playing: -> @autoplayId?

  startAutoPlay: ->
    @autoplayId = setInterval =>
      @next()
    , @options.delay

  stopAutoplay: ->
    if @playing()
      clearInterval @autoplayId
      @autoplayId = null

  play: -> 
    # TODO: handle first delay if specified
    @startAutoPlay()

    if @options.pauseOnHover
      @container.children()
        .on('mouseover', =>
          @pause()
        ).on('mouseleave', =>
          @resume()
        )

  next: -> @to @nextIndex
  
  previous: -> @to @previousIndex

  to: (index) -> 
    # TODO: Call callback method onTransition and onComplete
    unless @state is 'animating'
      @state = 'animating'
      @container.animate({ left: -(@size.width * index) }, @options.transitionSpeed, @options.transitionEasing, =>
        @updateTracker index
        @state = 'waiting'
      )

  pause: -> @stopAutoplay()

  resume: -> @startAutoPlay()

$ ->
  $.miniSlider = (element, options) ->
    # default plugin settings
    @defaults = {
      # general
      autoPlay:              true                # autoplay slides
      firstDelay:            5000                # delay before first transition
      delay:                 3000                # delay between slides
      containerClass:        'slider-container'  # slider container class name
            
      # slides
      currentClass:          'current'            # current slide class name
      previousClass:         'previous'           # previous slide class name
      nextClass:             'next'               # next slide class name

      # transition
      transitionSpeed:        500                # transition speed between slides
      transitionEasing:       'swing'            # easing animation for the slides transition

      # navigation
      pauseOnHover:           false               # pause on mouse over

      showNavigation:         true                # show next/previous buttons
      previousBtnClass:      'previousBtn'        # previous button class
      nextBtnClass:          'nextBtn'            # next button class
      previousBtnContent:    '&lsaquo;'           # previous button html content
      nextBtnContent:        '&rsaquo;'           # next button html content

      showPagination:         true                # show slider pagination
      paginationClass:        'pagination'        # pagination wrapper class
      currentPaginationClass: 'currentPagination' # current pagination list item class

      # callbacks
      onLoad:               ->                    # Function(), called when miniSlide is loading
      onReady:              ->                    # Function(), called when miniSlide is ready
      onTransition:         ->                    # Function(element, number), called when the slide is in sliding
      onComplete:           ->                    # Function(slide, number), called when the slide transition is complete      
    }

    ## private variables

    slider = {}

    ## public variables
    # plugin settings
    @settings = {}

    # jQuery version of DOM element attached to the plugin
    @$element = $ element

    ## public methods

    # get particular plugin setting
    @getSetting = (settingKey) ->
      @settings[settingKey]

    # call one of the plugin setting functions
    @callSettingFunction = (functionName) ->
      @settings[functionName]()

    # init function
    @init = ->
      # call onLoad callback method
      @settings = $.extend {}, @defaults, options
      slider = new Slider(@$element, @settings)

      slider.appendNavigation() if @getSetting 'showNavigation'
      slider.appendPagination() if @getSetting 'showPagination'
      # TODO: call onReady callback method
      slider.play() if @getSetting 'autoPlay'

    # initialise the plugin
    @init()

  $.fn.miniSlider = (options) ->
    return this.each ->
      if undefined == $(this).data 'miniSlider'
        plugin = new $.miniSlider this, options
        $(this).data 'miniSlider', plugin