#
# miniSlider, a slider plugin for jQuery
# Instructions: http://minijs.com/plugins/7/slider
# By: Matthieu Aussaguel, http://www.mynameismatthieu.com, @mattaussaguel
# Version: 1.0 Stable
# More info: http://minijs.com/
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
    @wrapper.after(@nextLink())
            .after(@previousLink())

    @nextLink().on 'click', =>
      @stopAutoplay()
      @next()
      return false

    @previousLink().on 'click', =>
      @stopAutoplay()
      @previous()
      return false

  appendPagination: ->
    @wrapper.after(@pagination())

    @pagination().on 'click', 'a', (e) =>
      @to (($ e.currentTarget).data().index - 1 )
      @stopAutoplay()
      return false

  previousLink: -> @$previousLink ||= $('<a />', { html: @options.previousBtnContent, class: @options.previousBtnClass, href: '#' })
  
  nextLink: -> @$nextLink ||= $('<a />', { html: @options.nextBtnContent, class: @options.nextBtnClass, href: '#' })

  pagination: ->
    unless @$pagination
      @$pagination = $('<ul />', class: @options.paginationClass)
      @$pagination.append("<li><a href='#' data-index='#{index + 1}'>#{index + 1}</a></li>") for slide, index in @slides

    @$pagination

  currentPaginationElement: -> @pagination().find("li:eq(#{@currentIndex})")

  count: -> @slides.length

  initSlides: ->
    # Create array of slide objects
    @slides = []
    @container.children().each (index, element) => 
       @slides.push(new Slide($(element), index, @options))  

    @container.css('width', @size.width * @slides.length)
    @initTracker()

  currentSlideElement: -> @slideElementForIndex @currentIndex

  previousSlideElement: -> @slideElementForIndex @previousIndex

  nextSlideElement: -> @slideElementForIndex @nextIndex

  slideElementForIndex: (index) -> @slides[index].element

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
    @autoplayId = window.setInterval =>
      @next()
    , @options.delay

  stopAutoplay: ->
    if @playing()
      clearInterval @autoplayId
      @autoplayId = null

  play: -> 
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

  callAnimationCallbackFunction: (functionName, index) -> 
    @options[functionName](@slideElementForIndex(index),index + 1)

  to: (index) -> 
    unless @state is 'animating'
      @state = 'animating'
      @callAnimationCallbackFunction 'onTransition', index

      @container.animate({ left: 0 - (@size.width * index) }, @options.transitionSpeed, @options.transitionEasing, =>
        @updateTracker index
        @state = 'waiting'
        @callAnimationCallbackFunction 'onComplete', index
      )

  pause: -> @stopAutoplay()

  resume: -> @startAutoPlay()

$ ->
  $.miniSlider = (element, options) ->
    # default plugin settings
    @defaults =
      # general
      autoPlay:              true                # autoplay slides
      delay:                 3000                # delay between slides
      containerClass:        'slider-container'  # slider container class name
            
      # slides
      currentClass:          'current'            # current slide class name
      previousClass:         'previous'           # previous slide class name
      nextClass:             'next'               # next slide class name

      # transition
      transitionSpeed:        500                # transition speed between slides
      transitionEasing:       ''            # easing animation for the slides transition

      # navigation
      pauseOnHover:           false               # pause on mouse over

      showNavigation:         true                # show next/previous buttons
      previousBtnClass:      'previous-btn'        # previous button class
      nextBtnClass:          'next-btn'            # next button class
      previousBtnContent:    '&lsaquo;'           # previous button html content
      nextBtnContent:        '&rsaquo;'           # next button html content

      showPagination:         true                # show slider pagination
      paginationClass:        'pagination'        # pagination wrapper class
      currentPaginationClass: 'current-pagination' # current pagination list item class

      # callbacks
      onLoad:               ->                    # Function(), called when miniSlider is loading
      onReady:              ->                    # Function(), called when miniSlider is ready
      onTransition:         ->                    # Function(slide, number), called when the slide is in sliding
      onComplete:           ->                    # Function(slide, number), called when the slide transition is complete      

    

    ## public variables
    # plugin settings
    @settings = {}

    # jQuery version of DOM element attached to the plugin
    @$element = $ element

    # slider object
    @slider = {}

    ## public methods

    # get particular plugin setting
    @getSetting = (settingKey) ->
      @settings[settingKey]

    # call one of the plugin setting functions
    @callSettingFunction = (functionName) ->
      @settings[functionName]()

    # init function
    @init = ->
      @settings = $.extend {}, @defaults, options
      @callSettingFunction 'onLoad'

      @slider = new Slider(@$element, @settings)
      @slider.appendPagination() if @getSetting 'showPagination'
      @slider.appendNavigation() if @getSetting 'showNavigation'

      @callSettingFunction 'onReady'
      @slider.play() if @getSetting 'autoPlay'

    # initialise the plugin
    @init()

    this

  $.fn.miniSlider = (options) ->
    return this.each ->
      if undefined == $(this).data 'miniSlider'
        plugin = new $.miniSlider this, options
        $(this).data 'miniSlider', plugin