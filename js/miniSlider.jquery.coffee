#
# CoffeeScript jQuery Plugin Boilerplate
# By: Matthieu Aussaguel, http://www.mynameismatthieu.com, @matthieu_tweets
# Version: 1.0 alpha 1.0
# Updated: June 27th, 2011
#

$ ->
  $.miniSlider = (element, options) ->
    # default plugin settings
    @defaults = {
      # general
      autoPlay:           true                # autoplay slides
      firstDelay:         2000                # delay before first transition
      delay:              1000                # delay between slides
      preloadImage:       ''                  # show preload images while loading 
      containerClass:     'mini-slider'       # slider container class name
            
      # slides
      currentSlideClass:  'current-slide'     # current slide class name
      previousSlideClass: 'previous-slide'    # previous slide class name
      nextSlideClass:     'next-slide'        # next slide class name

      # transition
      effect:              'slide'            # 'slide' | 'fade'
      transitionSpeed:     500                # transition speed between slides
      transitionEasing:    'swing'            # easing animation for the slides transition

      # navigation
      pauseOnHover:        false              # pause slider when hovering slider

      showNextPrev:        false              # show next/previous buttons
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
      @settings = $.extend {}, @defaults, options
    # end init method

    # initialise the plugin
    @init()

  $.fn.miniSlider = (options) ->
    return this.each ->
      if undefined == $(this).data 'miniSlider'
        plugin = new $.miniSlider this, options
        $(this).data 'miniSlider', plugin