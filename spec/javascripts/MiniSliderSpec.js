(function() {

  describe('miniSlider', function() {
    var sliderFixture;
    sliderFixture = '<div id="slider">\
                    <p>some text</p>\
                    <p>some text</p>\
                    <p>some text</p>\
                    <p>some text</p>\
                  </div>';
    beforeEach(function() {
      setFixtures(sliderFixture);
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
      describe('initialization', function() {
        describe('containerClass', function() {
          it('should wrapp the slider in a div with the css class slider-container by default', function() {
            var $wrapper;
            new $.miniSlider(this.$element);
            $wrapper = this.$element;
            expect($wrapper.prop('tagName')).toBe('DIV');
            return expect(this.$element.parent()).toHaveClass('slider-container');
          });
          return it('should wrapp the slider in a div with a custom css class when specified', function() {
            var $wrapper;
            new $.miniSlider(this.$element, {
              containerClass: 'custom-class'
            });
            $wrapper = this.$element;
            expect($wrapper.prop('tagName')).toBe('DIV');
            return expect(this.$element.parent()).toHaveClass('custom-class');
          });
        });
        describe('currentClass', function() {
          it('should add the css class "current" to the first element by default', function() {
            new $.miniSlider(this.$element);
            expect(this.$element.children('.current').length).toBe(1);
            return expect(this.$element.children().first()).toHaveClass('current');
          });
          return it('should add a custom css clas to the first element when specified', function() {
            new $.miniSlider(this.$element, {
              currentClass: 'custom-class'
            });
            expect(this.$element.children('.custom-class').length).toBe(1);
            return expect(this.$element.children().first()).toHaveClass('custom-class');
          });
        });
        describe('previousClass', function() {
          it('should add the css class "previous" to the last element by default', function() {
            new $.miniSlider(this.$element);
            expect(this.$element.children('.previous').length).toBe(1);
            return expect(this.$element.children().last()).toHaveClass('previous');
          });
          return it('should add a custom css clas to the last element when specified', function() {
            new $.miniSlider(this.$element, {
              previousClass: 'custom-class'
            });
            expect(this.$element.children('.custom-class').length).toBe(1);
            return expect(this.$element.children().last()).toHaveClass('custom-class');
          });
        });
        describe('nextClass', function() {
          it('should add the css class "next" to the second element by default', function() {
            new $.miniSlider(this.$element);
            expect(this.$element.children('.next').length).toBe(1);
            return expect(this.$element.children()[1]).toHaveClass('next');
          });
          return it('should add a custom css clas to the second element when specified', function() {
            new $.miniSlider(this.$element, {
              nextClass: 'custom-class'
            });
            expect(this.$element.children('.custom-class').length).toBe(1);
            return expect(this.$element.children()[1]).toHaveClass('custom-class');
          });
        });
        describe('navigation', function() {
          describe('showNavigation', function() {
            it('should generate the navigation by default', function() {
              new $.miniSlider(this.$element);
              expect($('a.previous-btn')).toExist();
              return expect($('a.next-btn')).toExist();
            });
            return it('should not generate the naviation is showNavigation is set to false', function() {
              new $.miniSlider(this.$element, {
                showNavigation: false
              });
              expect($('a.previous-btn')).not.toExist();
              return expect($('a.next-btn')).not.toExist();
            });
          });
          describe('previousBtnClass', function() {
            it('should add the css class previous-btn to the previous button by default', function() {
              new $.miniSlider(this.$element);
              return expect($('a.previous-btn')).toExist();
            });
            it('should add the pevious button next to the slider container', function() {
              new $.miniSlider(this.$element);
              return expect($('.slider-container').next()).toHaveClass('previous-btn');
            });
            return it('should add a custom css button to the previous button when specified', function() {
              new $.miniSlider(this.$element, {
                previousBtnClass: 'custom-class'
              });
              expect($('a.previous-btn')).not.toExist();
              return expect($('a.custom-class')).toExist();
            });
          });
          describe('nextBtnClass', function() {
            it('should add the css class next-btn to the next button by default', function() {
              new $.miniSlider(this.$element);
              return expect($('a.next-btn')).toExist();
            });
            it('should add the next button next to the preious button', function() {
              new $.miniSlider(this.$element);
              return expect($('a.previous-btn').next()).toHaveClass('next-btn');
            });
            return it('should add a custom css button to the next button when specified', function() {
              new $.miniSlider(this.$element, {
                nextBtnClass: 'custom-class'
              });
              expect($('a.next-btn')).not.toExist();
              return expect($('a.custom-class')).toExist();
            });
          });
          describe('previousBtnContent', function() {
            it('should add the left arrow as previous button content by default', function() {
              new $.miniSlider(this.$element);
              return expect($('a.previous-btn')).toHaveText('‹');
            });
            return it('should add a custom text as previous button content when specified', function() {
              new $.miniSlider(this.$element, {
                previousBtnContent: 'custom text'
              });
              return expect($('a.previous-btn')).toHaveText('custom text');
            });
          });
          return describe('nextBtnContent', function() {
            it('should add the right arrow as next button content by default', function() {
              new $.miniSlider(this.$element);
              return expect($('a.next-btn')).toHaveText('›');
            });
            return it('should add a custom text as previous button content when specified', function() {
              new $.miniSlider(this.$element, {
                nextBtnContent: 'some text'
              });
              return expect($('a.next-btn')).toHaveText('some text');
            });
          });
        });
        return describe('pagination', function() {
          describe('showPagination', function() {
            it('should show the pagination by default', function() {
              new $.miniSlider(this.$element);
              return expect($('ul.pagination')).toExist();
            });
            it('should be added next to the next button', function() {
              new $.miniSlider(this.$element);
              return expect($('.next-btn').next()).toHaveClass('pagination');
            });
            it('should have as many list items as slides', function() {
              new $.miniSlider(this.$element);
              return expect($('ul.pagination > li').length).toBe(this.$element.children().length);
            });
            return it('should not show the pagination when showPagination is false', function() {
              new $.miniSlider(this.$element, {
                showPagination: false
              });
              return expect($('ul.pagination')).not.toExist();
            });
          });
          describe('paginationClass', function() {
            it('should add the css class "pagination" to the pagination by default', function() {
              new $.miniSlider(this.$element);
              return expect($('ul.pagination')).toExist();
            });
            return it('should add a custom css class to the pagination ul when specified', function() {
              new $.miniSlider(this.$element, {
                paginationClass: 'custom-class'
              });
              expect($('ul.pagination')).not.toExist();
              return expect($('ul.custom-class')).toExist();
            });
          });
          return describe('currentPaginationClass', function() {
            it('should add the default current pagination class to the first pagination item by default', function() {
              new $.miniSlider(this.$element);
              return expect($('ul.pagination > li').first()).toHaveClass('current-pagination');
            });
            return it('should add a custom current pagination class to the first pagination item when specified', function() {
              new $.miniSlider(this.$element, {
                currentPaginationClass: 'custom-class'
              });
              return expect($('ul.pagination > li').first()).toHaveClass('custom-class');
            });
          });
        });
      });
      describe('animation', function() {
        beforeEach(function() {
          return this.clock = sinon.useFakeTimers();
        });
        afterEach(function() {
          return this.clock.restore();
        });
        describe('delay', function() {
          it('should apply a delay of 3000 between slides by default', function() {
            spyOn(window, 'setInterval');
            new $.miniSlider(this.$element);
            return expect(window.setInterval).toHaveBeenCalledWith(jasmine.any(Function), 3000);
          });
          return it('should apply a custom delay between slides when specified', function() {
            spyOn(window, 'setInterval');
            new $.miniSlider(this.$element, {
              delay: 5000
            });
            return expect(window.setInterval).toHaveBeenCalledWith(jasmine.any(Function), 5000);
          });
        });
        describe('autoPlay', function() {
          it('should autoplay the slider on load by default', function() {
            var plugin;
            plugin = new $.miniSlider(this.$element);
            spyOn(plugin.slider, 'next');
            this.clock.tick(3000);
            return expect(plugin.slider.next).toHaveBeenCalled();
          });
          return it('should not autoplay the slider on load when autoPlay is false', function() {
            var plugin;
            plugin = new $.miniSlider(this.$element, {
              autoPlay: false
            });
            spyOn(plugin.slider, 'next');
            this.clock.tick(3000);
            return expect(plugin.slider.next).not.toHaveBeenCalled();
          });
        });
        describe('transitionSpeed', function() {
          it('should animate the slides for 500 milliseconds in between each other by default', function() {
            var plugin;
            plugin = new $.miniSlider(this.$element);
            spyOn(plugin.slider.container, 'animate');
            this.clock.tick(3000);
            return expect(plugin.slider.container.animate).toHaveBeenCalledWith(jasmine.any(Object), 500, jasmine.any(String), jasmine.any(Function));
          });
          return it('should animate the slides for a custom time when specified', function() {
            var plugin;
            plugin = new $.miniSlider(this.$element, {
              transitionSpeed: 1000
            });
            spyOn(plugin.slider.container, 'animate');
            this.clock.tick(3000);
            return expect(plugin.slider.container.animate).toHaveBeenCalledWith(jasmine.any(Object), 1000, jasmine.any(String), jasmine.any(Function));
          });
        });
        describe('transitionEasing', function() {
          it('should not use any easing equation when animating slides by default', function() {
            var plugin;
            plugin = new $.miniSlider(this.$element);
            spyOn(plugin.slider.container, 'animate');
            this.clock.tick(3000);
            return expect(plugin.slider.container.animate).toHaveBeenCalledWith(jasmine.any(Object), jasmine.any(Number), '', jasmine.any(Function));
          });
          return it('should use custom a easing equation when animating slides when specified', function() {
            var plugin;
            plugin = new $.miniSlider(this.$element, {
              transitionEasing: 'swing'
            });
            spyOn(plugin.slider.container, 'animate');
            this.clock.tick(3000);
            return expect(plugin.slider.container.animate).toHaveBeenCalledWith(jasmine.any(Object), jasmine.any(Number), 'swing', jasmine.any(Function));
          });
        });
        return describe('pauseOnHover', function() {
          it('should not pause the slider when hovering a slide by default', function() {
            var plugin;
            plugin = new $.miniSlider(this.$element);
            spyOn(plugin.slider, 'pause');
            plugin.slider.slides[0].element.trigger('mouseover');
            return expect(plugin.slider.pause).not.toHaveBeenCalled();
          });
          it('should pause the slider when hovering a slide iff pauseOnHover is true', function() {
            var plugin;
            plugin = new $.miniSlider(this.$element, {
              pauseOnHover: true
            });
            spyOn(plugin.slider, 'pause');
            plugin.slider.slides[0].element.trigger('mouseover');
            return expect(plugin.slider.pause).toHaveBeenCalled();
          });
          return it('should resume autoplay when hovering out a slide', function() {
            var plugin;
            plugin = new $.miniSlider(this.$element, {
              pauseOnHover: true
            });
            spyOn(plugin.slider, 'resume');
            plugin.slider.slides[0].element.trigger('mouseover').trigger('mouseleave');
            return expect(plugin.slider.resume).toHaveBeenCalled();
          });
        });
      });
      describe('navigation', function() {});
      return describe('callbacks', function() {
        beforeEach(function() {
          this.callback = sinon.spy();
          return this.clock = sinon.useFakeTimers();
        });
        afterEach(function() {
          this.callback.reset();
          return this.clock.restore();
        });
        it('should call onLoad callback when slider is initializing', function() {
          new $.miniSlider(this.$element, {
            onLoad: this.callback
          });
          return expect(this.callback.calledWith()).toBeTruthy();
        });
        it('should call onReady callback when slider is initializing', function() {
          var anotherCallback;
          anotherCallback = sinon.spy();
          new $.miniSlider(this.$element, {
            onLoad: this.callback,
            onReady: anotherCallback
          });
          expect(anotherCallback.calledWith()).toBeTruthy();
          return expect(anotherCallback.calledAfter(this.callback)).toBeTruthy();
        });
        it('should call onTransition when are slides animating', function() {
          var index, plugin, _i;
          plugin = new $.miniSlider(this.$element, {
            onTransition: this.callback,
            autoPlay: false,
            transitionSpeed: 0
          });
          expect(this.callback.called).toBeFalsy();
          for (index = _i = 1; _i <= 3; index = ++_i) {
            plugin.slider.next();
            expect(this.callback.calledWith(plugin.slider.slides[index].element, index + 1)).toBeTruthy();
          }
          plugin.slider.next();
          return expect(this.callback.calledWith(plugin.slider.slides[0].element, 1)).toBeTruthy();
        });
        return it('should call onComplete callback when the animation is complete', function() {
          var plugin;
          plugin = new $.miniSlider(this.$element, {
            onComplete: this.callback,
            autoPlay: false
          });
          expect(this.callback.called).toBeFalsy();
          plugin.slider.next();
          expect(this.callback.called).toBeFalsy();
          this.clock.tick(600);
          return expect(this.callback.called).toBeTruthy();
        });
      });
    });
  });

}).call(this);
