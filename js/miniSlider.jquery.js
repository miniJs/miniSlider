(function() {
  var Slide, Slider;

  Slide = (function() {

    function Slide(element, index, options) {
      this.element = element;
      this.index = index;
      this.options = options;
      this.element.css({
        position: 'absolute',
        top: 0,
        left: this.index * this.element.width()
      });
    }

    return Slide;

  })();

  Slider = (function() {

    function Slider(container, options) {
      this.container = container;
      this.options = options;
      this.state = 'waiting';
      this.size = {
        height: this.container.height(),
        width: this.container.width()
      };
      this.container.css({
        overflow: 'hidden',
        position: 'absolute',
        top: 0,
        left: 0
      }).wrap("<div class='" + this.options.containerClass + "' style='position: relative; overflow: hidden;'/>");
      this.wrapper = this.container.parent();
      this.initSlides();
    }

    Slider.prototype.appendNavigation = function() {
      var _this = this;
      this.wrapper.append(this.previousLink()).append(this.nextLink());
      this.nextLink().on('click', function() {
        _this.stopAutoplay();
        _this.next();
        return false;
      });
      return this.previousLink().on('click', function() {
        _this.stopAutoplay();
        _this.previous();
        return false;
      });
    };

    Slider.prototype.appendPagination = function() {
      var _this = this;
      this.wrapper.append(this.pagination());
      return this.pagination().on('click', 'a', function(e) {
        _this.to(($(e.currentTarget)).attr('href').replace('#', '') - 1);
        _this.stopAutoplay();
        return false;
      });
    };

    Slider.prototype.previousLink = function() {
      return this.$previousLink || (this.$previousLink = $('<a />', {
        html: this.options.previousBtnContent,
        "class": this.options.previousBtnClass,
        href: '#'
      }));
    };

    Slider.prototype.nextLink = function() {
      return this.$nextLink || (this.$nextLink = $('<a />', {
        html: this.options.nextBtnContent,
        "class": this.options.nextBtnClass,
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

    Slider.prototype.count = function() {
      return this.slides.length;
    };

    Slider.prototype.initSlides = function() {
      var _this = this;
      this.slides = [];
      this.container.children().each(function(index, element) {
        return _this.slides.push(new Slide($(element), index, _this.options));
      });
      this.container.css('width', this.size.width * this.slides.length);
      return this.initTracker();
    };

    Slider.prototype.initTracker = function() {
      this.currentIndex = 0;
      this.previousIndex = this.count() - 1;
      this.nextIndex = 1;
      return this.addCssClasses();
    };

    Slider.prototype.updateTracker = function(newIndex) {
      this.removeCssClasses();
      this.currentIndex = newIndex;
      this.previousIndex = newIndex === 0 ? this.count() - 1 : newIndex - 1;
      this.nextIndex = newIndex === this.count() - 1 ? 0 : newIndex + 1;
      return this.addCssClasses();
    };

    Slider.prototype.addCssClasses = function() {
      this.slides[this.currentIndex].element.addClass(this.options.currentClass);
      this.slides[this.previousIndex].element.addClass(this.options.previousClass);
      this.slides[this.nextIndex].element.addClass(this.options.nextClass);
      return this.pagination().find("li:eq(" + this.currentIndex + ")").addClass(this.options.currentPaginationClass);
    };

    Slider.prototype.removeCssClasses = function() {
      this.slides[this.currentIndex].element.removeClass(this.options.currentClass);
      this.slides[this.previousIndex].element.removeClass(this.options.previousClass);
      this.slides[this.nextIndex].element.removeClass(this.options.nextClass);
      return this.pagination().find("li:eq(" + this.currentIndex + ")").removeClass(this.options.currentPaginationClass);
    };

    Slider.prototype.playing = function() {
      return this.autoplayId != null;
    };

    Slider.prototype.startAutoPlay = function() {
      var _this = this;
      return this.autoplayId = setInterval(function() {
        return _this.next();
      }, this.options.delay);
    };

    Slider.prototype.stopAutoplay = function() {
      if (this.playing()) {
        clearInterval(this.autoplayId);
        return this.autoplayId = null;
      }
    };

    Slider.prototype.play = function() {
      var _this = this;
      this.startAutoPlay();
      if (this.options.pauseOnHover) {
        return this.container.children().on('mouseover', function() {
          return _this.pause();
        }).on('mouseleave', function() {
          return _this.resume();
        });
      }
    };

    Slider.prototype.next = function() {
      return this.to(this.nextIndex);
    };

    Slider.prototype.previous = function() {
      return this.to(this.previousIndex);
    };

    Slider.prototype.to = function(index) {
      var _this = this;
      if (this.state !== 'animating') {
        this.state = 'animating';
        return this.container.animate({
          left: -(this.size.width * index)
        }, this.options.transitionSpeed, this.options.transitionEasing, function() {
          _this.updateTracker(index);
          return _this.state = 'waiting';
        });
      }
    };

    Slider.prototype.pause = function() {
      return this.stopAutoplay();
    };

    Slider.prototype.resume = function() {
      return this.startAutoPlay();
    };

    return Slider;

  })();

  $(function() {
    $.miniSlider = function(element, options) {
      var slider;
      this.defaults = {
        autoPlay: true,
        firstDelay: 5000,
        delay: 3000,
        containerClass: 'slider-container',
        currentClass: 'current',
        previousClass: 'previous',
        nextClass: 'next',
        transitionSpeed: 500,
        transitionEasing: 'swing',
        pauseOnHover: false,
        showNavigation: true,
        previousBtnClass: 'previousBtn',
        nextBtnClass: 'nextBtn',
        previousBtnContent: '&lsaquo;',
        nextBtnContent: '&rsaquo;',
        showPagination: true,
        paginationClass: 'pagination',
        currentPaginationClass: 'currentPagination',
        onLoad: function() {},
        onReady: function() {},
        onTransition: function() {},
        onComplete: function() {}
      };
      slider = {};
      this.settings = {};
      this.$element = $(element);
      this.getSetting = function(settingKey) {
        return this.settings[settingKey];
      };
      this.callSettingFunction = function(functionName) {
        return this.settings[functionName]();
      };
      this.init = function() {
        this.settings = $.extend({}, this.defaults, options);
        slider = new Slider(this.$element, this.settings);
        if (this.getSetting('showNavigation')) slider.appendNavigation();
        if (this.getSetting('showPagination')) slider.appendPagination();
        if (this.getSetting('autoPlay')) return slider.play();
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
