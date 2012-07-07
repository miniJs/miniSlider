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
