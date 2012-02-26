#
# CoffeeScript jQuery Plugin Boilerplate
# By: Matthieu Aussaguel, http://www.mynameismatthieu.com, @matthieu_tweets
# Version: 1.0 alpha 1.0
# Updated: February 21, 2012
#
class Slide
  constructor: (@element, @index, @options) ->
    @element.css { position: 'absolute', top: 0, left: @index * @element.width() }

class Slider
  constructor: (@container, @options) ->
    @size = 
      height: @container.height()
      width: @container.width()

    @container.css({ overflow: 'hidden', position: 'absolute', top: 0, left: 0 })
              .wrap("<div class='#{@options.containerClass}' style='position: relative; overflow: hidden;'/>")
    @wrapper = @container.parent()

    @initSlides()
    @container.css('width', @size.width * @slides.length)
    @initTracker()              
              
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

    @pagination().find("li:eq(#{@currentIndex})")
                 .addClass(@options.currentPaginationClass)

    @pagination().on 'click', 'a', (e) =>
      @to ($ e.currentTarget).attr('href').replace('#','')
      return false

  previousLink: ->
    @$previousLink ||= $('<a />', { html: @options.previousBtnContent, class: @options.previousBtnClass, href: '#' })
  
  nextLink: ->
    @$nextLink ||= $('<a />', { html: @options.nextBtnContent, class: @options.nextBtnClass, href: '#' })

  pagination: ->
    unless @$pagination
      @$pagination = $('<ul />', class: @options.paginationClass)
      @$pagination.append("<li><a href='##{index + 1}'>#{index + 1}</li>") for slide, index in @slides
    @$pagination

  count: -> @slides.length

  initSlides: ->
    # Create array of slide objects
    @slides = []
    @container.children().each (index, element) =>  @slides.push(new Slide(($ element), index, @options))  

  initTracker: -> @updateTracker 0

  updateTracker: (newIndex) ->
    @currentIndex  = newIndex
    @previousIndex = if newIndex is 0 then @count() - 1 else newIndex - 1
    @nextIndex = if newIndex is @count() - 1 then 0 else newIndex + 1

  playing: -> 
    @autoplayId?

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

  next: -> 
    # TODO: update the state while animating and after animation
    # Call callback method onTransition and onComplete
    leftPosition = if @nextIndex is 0 then 0 else (@container.position().left - @size.width)
    @container.animate({ left: leftPosition }, @options.transitionSpeed, @options.transitionEasing, =>
      @updateTracker @nextIndex
    )
  
  previous: -> 
    # TODO: update the state while animating and after animation
    # Call callback method onTransition and onComplete

    leftPosition = if @previousIndex is @count() - 1 then -(@container.width() - @size.width) else (@container.position().left + @size.width)
    @container.animate({ left: leftPosition }, @options.transitionSpeed, @options.transitionEasing, =>
      @updateTracker @previousIndex
    )

  to: (number) -> 
    # TODO: go to slide #number and update the index

  pause: ->
    # TODO: pause the autoplaying and update the state
    @stopAutoplay()

  resume: ->
    # TODO: resume the autoplaying and update the state
    @startAutoPlay()

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
      # call onReady callback method
      slider.play() if @getSetting 'autoPlay'

    # initialise the plugin
    @init()

  $.fn.miniSlider = (options) ->
    return this.each ->
      if undefined == $(this).data 'miniSlider'
        plugin = new $.miniSlider this, options
        $(this).data 'miniSlider', plugin