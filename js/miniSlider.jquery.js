(function() {
  var Slide, Slider;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Slide = (function() {
    function Slide(slide, options) {
      this.slide = slide;
      this.options = options;
    }
    Slide.prototype.addCurrentClass = function() {
      return this.slide.addClass(this.options.currentClass);
    };
    Slide.prototype.addNextClass = function() {
      return this.slide.addClass(this.options.nextClass);
    };
    Slide.prototype.addPreviousClass = function() {
      return this.slide.addClass(this.options.previousClass);
    };
    Slide.prototype.removeCurrentClass = function() {
      return this.slide.removeClass(this.options.currentClass);
    };
    Slide.prototype.removeNextClass = function() {
      return this.slide.removeClass(this.options.nextClass);
    };
    Slide.prototype.removePreviousClass = function() {
      return this.slide.removeClass(this.options.previousClass);
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
      this.slides = [];
      this.container.children().each(__bind(function(index, element) {
        return this.slides.push(new Slide($(element), this.options));
      }, this));
      this.slides[0].addCurrentClass();
      this.slides[1].addNextClass();
      this.slides[this.itemsCount() - 1].addPreviousClass();
    }
    Slider.prototype.run = function() {
      return console.log('run');
    };
    Slider.prototype.appendNextPrev = function() {
      return this.wrapper.append(this.previousElement()).append(this.nextElement());
    };
    Slider.prototype.appendPagination = function() {
      return this.wrapper.append(this.pagination());
    };
    Slider.prototype.previousElement = function() {
      return $('<a />', {
        html: 'previous',
        "class": this.options.previousClass,
        href: '#'
      });
    };
    Slider.prototype.nextElement = function() {
      return $('<a />', {
        html: 'next',
        "class": this.options.nextClass,
        href: '#'
      });
    };
    Slider.prototype.pagination = function() {
      var index, pagination, slide, _len, _ref;
      pagination = $('<ul />', {
        "class": this.options.paginationClass
      });
      _ref = this.slides;
      for (index = 0, _len = _ref.length; index < _len; index++) {
        slide = _ref[index];
        pagination.append("<li><a href='#" + (index + 1) + "'>" + (index + 1) + "</li>");
      }
      return pagination;
    };
    Slider.prototype.itemsCount = function() {
      return this.slides.length;
    };
    Slider.prototype.slides = function() {
      return this.slides;
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
        if (this.getSetting('showNextPrev')) {
          slider.appendNextPrev();
        }
        if (this.getSetting('showPagination')) {
          slider.appendPagination();
        }
        if (this.getSetting('autoPlay')) {
          return slider.run();
        }
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
