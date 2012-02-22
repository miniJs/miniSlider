(function() {
  var Slide, Slider;

  Slide = (function() {

    function Slide(element, options) {
      this.element = element;
      this.options = options;
    }

    Slide.prototype.addCurrentClass = function() {
      return this.element.addClass(this.options.currentClass);
    };

    Slide.prototype.addNextClass = function() {
      return this.element.addClass(this.options.nextClass);
    };

    Slide.prototype.addPreviousClass = function() {
      return this.element.addClass(this.options.previousClass);
    };

    Slide.prototype.removeCurrentClass = function() {
      return this.element.removeClass(this.options.currentClass);
    };

    Slide.prototype.removeNextClass = function() {
      return this.element.removeClass(this.options.nextClass);
    };

    Slide.prototype.removePreviousClass = function() {
      return this.element.removeClass(this.options.previousClass);
    };

    Slide.prototype.cleanClasses = function() {
      this.removeCurrentClass();
      this.removeNextClass();
      return this.removePreviousClass();
    };

    return Slide;

  })();

  Slider = (function() {

    function Slider(container, options) {
      this.container = container;
      this.options = options;
      this.wrapper = this.container.css('overflow', 'hidden').wrap("<div class=" + this.options.containerClass + " />").parent();
      this.initSlides();
    }

    Slider.prototype.run = function() {
      var _this = this;
      console.log('run');
      return this.container.children().on('mouseenter', function() {
        return _this.pause();
      }).on('mouseleave', function() {
        return _this.resume();
      });
    };

    Slider.prototype.next = function() {
      return console.log('next');
    };

    Slider.prototype.previous = function() {
      return console.log('previous');
    };

    Slider.prototype.go = function(number) {
      return console.log("go to slide " + number);
    };

    Slider.prototype.pause = function() {
      return console.log('pause');
    };

    Slider.prototype.resume = function() {
      return console.log('resume');
    };

    Slider.prototype.appendNextPrev = function() {
      var _this = this;
      this.wrapper.append(this.previousElement()).append(this.nextElement());
      this.nextElement().on('click', function() {
        _this.next();
        return false;
      });
      return this.previousElement().on('click', function() {
        _this.previous();
        return false;
      });
    };

    Slider.prototype.appendPagination = function() {
      var _this = this;
      this.wrapper.append(this.pagination());
      return this.pagination().on('click', 'a', function(e) {
        _this.go(($(e.currentTarget)).attr('href').replace('#', ''));
        return false;
      });
    };

    Slider.prototype.previousElement = function() {
      return this.$previousElement || (this.$previousElement = $('<a />', {
        html: 'previous',
        "class": this.options.previousClass,
        href: '#'
      }));
    };

    Slider.prototype.nextElement = function() {
      return this.$nextElement || (this.$nextElement = $('<a />', {
        html: 'next',
        "class": this.options.nextClass,
        href: '#'
      }));
    };

    Slider.prototype.pagination = function() {
      var index, slide, _len, _ref;
      if (!this.$pagination) {
        this.$pagination = $('<ul />', {
          "class": this.options.paginationClass
        });
        _ref = this.slides;
        for (index = 0, _len = _ref.length; index < _len; index++) {
          slide = _ref[index];
          this.$pagination.append("<li><a href='#" + (index + 1) + "'>" + (index + 1) + "</li>");
        }
      }
      return this.$pagination;
    };

    Slider.prototype.itemsCount = function() {
      return this.slides.length;
    };

    Slider.prototype.slides = function() {
      return this.slides;
    };

    Slider.prototype.initSlides = function() {
      var _this = this;
      this.slides = [];
      this.container.children().each(function(index, element) {
        return _this.slides.push(new Slide($(element), _this.options));
      });
      return this.initTracker();
    };

    Slider.prototype.initTracker = function() {
      this.currentIndex = 0;
      this.nextIndex = 1;
      this.previousIndex = this.itemsCount() - 1;
      this.slides[this.currentIndex].addCurrentClass();
      this.slides[this.nextIndex].addNextClass();
      return this.slides[this.previousIndex].addPreviousClass();
    };

    return Slider;

  })();

  $(function() {
    $.miniSlider = function(element, options) {
      var setState, slider, state;
      this.defaults = {
        autoPlay: true,
        firstDelay: 2000,
        delay: 1000,
        preloadImage: '',
        containerClass: 'slider-container',
        currentClass: 'current',
        previousClass: 'previous',
        nextClass: 'next',
        effect: 'slide',
        transitionSpeed: 500,
        transitionEasing: 'swing',
        pauseOnHover: false,
        showNextPrev: true,
        previousClass: 'previous',
        nextClass: 'next',
        showPagination: true,
        paginationClass: 'pagination',
        onLoad: function() {},
        onReady: function() {},
        onTransition: function() {},
        onComplete: function() {}
      };
      state = '';
      slider = {};
      this.settings = {};
      this.$element = $(element);
      setState = function(_state) {
        return state = _state;
      };
      this.getState = function() {
        return state;
      };
      this.getSetting = function(settingKey) {
        return this.settings[settingKey];
      };
      this.callSettingFunction = function(functionName) {
        return this.settings[functionName]();
      };
      this.init = function() {
        setState('loading');
        this.settings = $.extend({}, this.defaults, options);
        slider = new Slider(this.$element, this.settings);
        setState('ready');
        if (this.getSetting('showNextPrev')) slider.appendNextPrev();
        if (this.getSetting('showPagination')) slider.appendPagination();
        if (this.getSetting('autoPlay')) return slider.run();
      };
      return this.init();
    };
    return $.fn.miniSlider = function(options) {
      return this.each(function() {
        var plugin;
        if (void 0 === $(this).data('miniSlider')) {
          plugin = new $.miniSlider(this, options);
          return $(this).data('miniSlider', plugin);
        }
      });
    };
  });

}).call(this);
