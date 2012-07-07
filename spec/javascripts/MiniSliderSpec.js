(function() {

  describe('miniSlider', function() {
    beforeEach(function() {
      loadFixtures('fragment.html');
      return this.$element = $('#slider');
    });
    return describe('plugin behaviour', function() {
      it('should be available on the jQuery object', function() {
        return expect($.fn.miniSlider).toBeDefined();
      });
      it('should be chainable', function() {
        return expect(this.$element.miniSlider()).toBe(this.$element);
      });
      it('should offer default values', function() {
        var plugin;
        plugin = new $.miniSlider(this.$element);
        return expect(plugin.defaults).toBeDefined();
      });
      it('should overwrite the settings', function() {
        var plugin;
        plugin = new $.miniSlider(this.$element, {
          autoPlay: false,
          delay: 500
        });
        expect(plugin.settings.autoPlay).toBeFalsy();
        return expect(plugin.settings.delay).toBe(500);
      });
      describe('initialization', function() {});
      describe('animation', function() {});
      describe('navigation', function() {});
      return describe('callbacks', function() {
        return beforeEach(function() {
          return this.callback = jasmine.createSpy('callback');
        });
      });
    });
  });

}).call(this);
