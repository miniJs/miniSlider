(function() {

  describe('miniSlider', function() {
    var options;
    options = {
      autoPlay: false
    };
    beforeEach(function() {
      loadFixtures('fragment.html');
      return this.$element = $('#slider');
    });
    it('should be available on the jQuery object', function() {
      return expect($.fn.miniSlider).toBeDefined();
    });
    it('should be chainable', function() {
      return expect(this.$element.miniSlider(options)).toBe(this.$element);
    });
    it('should offer default values', function() {
      var plugin;
      plugin = new $.miniSlider(this.$element[0], options);
      return expect(plugin.defaults).toBeDefined();
    });
    return it('should overwrite the settings', function() {
      var plugin;
      plugin = new $.miniSlider(this.$element[0], options);
      return expect(plugin.settings.autoPlay).toBeFalsy;
    });
  });

}).call(this);
