(function() {
  $(function() {
    $.miniSlider = function(element, options) {
      var setState, state;
      this.defaults = {
        autoPlay: true,
        firstDelay: 2000,
        delay: 1000,
        preloadImage: '',
        containerClass: 'mini-slider',
        currentSlideClass: 'current-slide',
        previousSlideClass: 'previous-slide',
        nextSlideClass: 'next-slide',
        effect: 'slide',
        transitionSpeed: 500,
        transitionEasing: 'swing',
        pauseOnHover: false,
        showNextPrev: false,
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
        return this.settings = $.extend({}, this.defaults, options);
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
