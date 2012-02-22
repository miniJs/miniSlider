#
# CoffeeScript jQuery Plugin Boilerplate
# By: Matthieu Aussaguel, http://www.mynameismatthieu.com, @matthieu_tweets
# Version: 1.0 alpha 1.0
# Updated: February 21, 2012
#
class Slide
  constructor: (@element, @options) ->

  addCurrentClass:      -> @element.addClass @options.currentClass

  addNextClass:         -> @element.addClass @options.nextClass

  addPreviousClass:     -> @element.addClass @options.previousClass

  removeCurrentClass:   -> @element.removeClass @options.currentClass

  removeNextClass:      -> @element.removeClass @options.nextClass

  removePreviousClass:  -> @element.removeClass @options.previousClass

  cleanClasses: ->
    @removeCurrentClass()
    @removeNextClass()
    @removePreviousClass()

class Slider
  constructor: (@container, @options) ->
    @wrapper = @container.css('overflow', 'hidden')
              .wrap("<div class=#{@options.containerClass} />")
              .parent()

    @initSlides()
              
  run: -> 
    console.log 'run'
    @container.children()
      .on('mouseenter', =>
        @pause()
      ).on('mouseleave', =>
        @resume()
      )
    

  next: -> console.log 'next'
  
  previous: -> console.log 'previous'

  go: (number) -> console.log "go to slide #{number}"

  pause: -> console.log 'pause'

  resume: -> console.log 'resume'
              
  appendNextPrev: ->
    @wrapper.append(@previousElement())
            .append(@nextElement())

    @nextElement().on 'click', =>
      @next()
      return false

    @previousElement().on 'click', =>
      @previous()
      return false

  appendPagination: ->
    @wrapper.append(@pagination())

    @pagination().on 'click', 'a', (e) =>
      @go ($ e.currentTarget).attr('href').replace('#','')
      return false

  previousElement: ->
    @$previousElement ||= $('<a />', { html: 'previous', class: @options.previousClass, href: '#' })
  
  nextElement: ->
    @$nextElement ||= $('<a />', { html: 'next', class: @options.nextClass, href: '#' })

  pagination: ->
    unless @$pagination
      @$pagination = $('<ul />', class: @options.paginationClass)
      @$pagination.append("<li><a href='##{index + 1}'>#{index + 1}</li>") for slide, index in @slides
    @$pagination

  itemsCount: ->
    @slides.length

  slides: ->
    @slides

  initSlides: ->
    @slides = []
    @container.children().each (index, element) =>  @slides.push(new Slide(($ element), @options))  
    @initTracker()

  initTracker: ->
    @currentIndex  = 0
    @nextIndex     = 1
    @previousIndex = @itemsCount() - 1

    @slides[@currentIndex].addCurrentClass()
    @slides[@nextIndex].addNextClass()
    @slides[@previousIndex].addPreviousClass()

$ ->
  $.miniSlider = (element, options) ->
    # default plugin settings
    @defaults = {
      # general
      autoPlay:           true                # autoplay slides
      firstDelay:         2000                # delay before first transition
      delay:              1000                # delay between slides
      preloadImage:       ''                  # show preload images while loading 
      containerClass:     'slider-container'  # slider container class name
            
      # slides
      currentClass:       'current'     # current slide class name
      previousClass:      'previous'    # previous slide class name
      nextClass:          'next'        # next slide class name

      # transition
      effect:              'slide'            # 'slide' | 'fade'
      transitionSpeed:     500                # transition speed between slides
      transitionEasing:    'swing'            # easing animation for the slides transition

      # navigation
      pauseOnHover:        false              # pause slider when hovering slider

      showNextPrev:        true               # show next/previous buttons
      previousClass:       'previous'         # previous button class
      nextClass:           'next'             # next button class

      showPagination:      true               # show slider pagination
      paginationClass:     'pagination'       # pagination wrapper class

      # callbacks
      onLoad:               ->                # Function(), called when miniSlide is loading
      onReady:              ->                # Function(), called when miniSlide is ready
      onTransition:         ->                # Function(element, number), called when the slide is in sliding
      onComplete:           ->                # Function(slide, number), called when the slide transition is complete      
    }

    ## private variables
    # current state
    state = ''

    slider = {}

    ## public variables
    # plugin settings
    @settings = {}

    # jQuery version of DOM element attached to the plugin
    @$element = $ element

    ## private methods
    # set current state
    setState = (_state) ->
      state = _state

    ## public methods
    #get current state
    @getState = ->
      state

    # get particular plugin setting
    @getSetting = (settingKey) ->
      @settings[settingKey]

    # call one of the plugin setting functions
    @callSettingFunction = (functionName) ->
      @settings[functionName]()

    # init function
    @init = ->
      setState 'loading'

      @settings = $.extend {}, @defaults, options
      slider = new Slider(@$element, @settings)
      setState 'ready'

      slider.appendNextPrev() if @getSetting 'showNextPrev'
      slider.appendPagination() if @getSetting 'showPagination'
      slider.run() if @getSetting 'autoPlay'

    # initialise the plugin
    @init()

  $.fn.miniSlider = (options) ->
    return this.each ->
      if undefined == $(this).data 'miniSlider'
        plugin = new $.miniSlider this, options
        $(this).data 'miniSlider', plugin