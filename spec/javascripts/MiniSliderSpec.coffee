describe 'miniSlider', ->
  options =
    autoPlay: false

  beforeEach ->
    loadFixtures 'fragment.html'
    @$element = $('#fixtures')

  it 'should be available on the jQuery object', ->
    expect($.fn.miniSlider).toBeDefined()

  it 'should be chainable', ->
    expect(@$element.miniSlider(options)).toBe(@$element)

  it 'should offers default values', ->
    plugin = new $.miniSlider(@$element[0], options)

    expect(plugin.defaults).toBeDefined()

  it 'should overwrites the settings', ->
    plugin = new $.miniSlider(@$element[0], options)
    expect(plugin.settings.autoPlay).toBeFalsy