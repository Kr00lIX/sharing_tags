#=require sharing_tags/share
#=require sharing_tags/share/base
#=require sharing_tags/share/facebook
fixture.preload("facebook.json")

describe "SharingTags.FacebookShare", ->

  subject = SharingTags.FacebookShare

  beforeEach ->
    @fb_fixture = fixture.load("facebook.json")[0]

  it "expect defined class", ->
    expect( SharingTags ).toBeDefined()
    expect( SharingTags.FacebookShare ).toBeDefined()

  describe "init sharing variables", ->
    beforeEach ->
      @fb_partial = @fb_fixture.partial
      expect(@fb_partial).toBeDefined()
      @fb_full = @fb_fixture.full
      expect(@fb_full).toBeDefined()

    it "expect init with main variables variables", ->
      @share = new subject(@fb_partial)

      expect( @share.url         ).toBe  @fb_partial.url
      expect( @share.title       ).toBe  @fb_partial.title
      expect( @share.description ).toBe  @fb_partial.description

      expect( @share.app_id      ).not.toBeDefined()
      expect( @share.return_url  ).not.toBeDefined()

    it "expect init full variables", ->
      @share = new subject(@fb_full)

      expect( @share.url         ).toBe  @fb_full.url
      expect( @share.title       ).toBe  @fb_full.title
      expect( @share.description ).toBe  @fb_full.description
      expect( @share.app_id      ).toBe  @fb_full.app_id
      expect( @share.return_url  ).toBe  @fb_full.return_url

    it "expect error if init without url", ->
      delete @fb_partial.url
      expect(=> new subject(@fb_partial)).toThrow(SharingTags.Error(), /Error could not initialize sharing class/)

  describe "share", ->

    it "expect call fb_ui sharing", ->
      @share = new subject(@fb_fixture.fb_ui)
      spyOn(@share, "_fb_ui")

      @share.share()
      expect(@share._fb_ui).toHaveBeenCalled()

    it "expect call sharer sharing", ->
      @share = new subject(@fb_fixture.sharer)
      spyOn(@share, "_sharer")

      @share.share()
      expect(@share._sharer).toHaveBeenCalled()

    it "expect call _dialog sharing", ->
      @share = new subject(@fb_fixture.dialog)
      spyOn(@share, "_dialog")

      @share.share()
      expect(@share._dialog).toHaveBeenCalled()

  describe "share provider", ->

    it "expect fb_ui as default provider", ->
      @share = new subject(@fb_fixture.fb_ui)
      expect(@share.provider).toBe "fb_ui"

    it "expect change provider to sharer on initialize", ->
      @share = new subject(@fb_fixture.sharer)
      expect(@share.provider).toBe "sharer"

  describe "events", ->
    describe "after sharing event", ->
      beforeEach ->
        @share = new subject(@fb_fixture.full)
        spyOn(@share, "_open_popup_check").andCallThrough()
        spyOn(@share, "_after_callback")
        jasmine.Clock.useMock()
        window.FB = jasmine.createSpyObj('FB', ['ui', 'init'])

      afterEach ->
        delete window.FB

      it "expect calling callback for fb_ui", ->
        FB.ui.andCallFake (params, callback)-> callback()

        @share.share("fb_ui")
        expect(@share._after_callback).toHaveBeenCalled()

      it "expect calling callback for sharer", ->
        @share.share('sharer')
        jasmine.Clock.tick(700)
        expect(@share._open_popup_check).toHaveBeenCalled()
        expect(@share._after_callback).not.toHaveBeenCalled()

        jasmine.Clock.tick(500 * 5)
        expect(@share._after_callback).toHaveBeenCalled()

      it "expect calling callback for dialog 2.5sec", ->
        @share.share('dialog')
        expect(@share._after_callback).not.toHaveBeenCalled()
        jasmine.Clock.tick(500 * 5)
        expect(@share._after_callback).toHaveBeenCalled()

  describe "#_sharer", ->
    beforeEach ->
      @fb = @fb_fixture.sharer
      @share = new subject(@fb)
      spyOn(@share, "_open_popup")

    it "expect call open popup with params", ->
      @share._sharer()
      expect(@share._open_popup).toHaveBeenCalled()
      expect(@share._open_popup).toHaveBeenCalledWith("http://www.facebook.com/sharer.php", u: @fb.url)

    it "expect error if init without url", ->
      delete @share.url
      expect(=> @share._sharer()).toThrow(SharingTags.Error(), /Error could not initialize sharing class/)

  describe "#_dialog", ->
    beforeEach ->
      @fb = @fb_fixture.dialog
      @share = new subject(@fb)
      spyOn(@share, "_open_popup")

    it "expect call open popup with params", ->
      @share._dialog()
      expect(@share._open_popup).toHaveBeenCalled()
      expect(@share._open_popup).toHaveBeenCalledWith(
        "http://www.facebook.com/dialog/share",
        jasmine.objectContaining(href: @fb.url, redirect_uri: @fb.return_url, app_id: @fb.app_id, display: 'page')
      )

    it "expect error if init without return_url", ->
      delete @share.return_url
      expect(=> @share._dialog()).toThrow(SharingTags.Error(), /Error could not initialize sharing class/)

    it "expect error if init without url", ->
      delete @share.url
      expect(=> @share._dialog()).toThrow(SharingTags.Error(), /Error could not initialize sharing class/)


  describe "#_fb_ui", ->
    beforeEach ->
      @fb = @fb_fixture.fb_ui
      @share = new subject(@fb)
      window.FB

    afterEach ->
      delete window.FB

    describe "loaded FB js SDK", ->
      beforeEach ->
        window.FB = jasmine.createSpyObj "FB", ['ui', 'init']

      it "expect call FB.ui method with params", ->
        @share._fb_ui()
        expect(FB.ui).toHaveBeenCalled()
        expect(FB.ui).toHaveBeenCalledWith(
          jasmine.objectContaining(app_id: @fb.app_id, href: @fb.url, method: 'share'),
          jasmine.any(Function)
        )

      it "expect error if init without url", ->
        delete @share.url
        expect(=> @share._fb_ui()).toThrow(SharingTags.Error(), /Error could not initialize sharing class/)

    describe "loading FB.ui", ->
      beforeEach ->
        spyOn(@share.constructor, "init").andCallThrough()
        spyOn(@share, "_fb_ui").andCallThrough()

      it "expect load FB.ui if FB undefined", ->
        expect(typeof FB).toBe('undefined')

        @share._fb_ui()
        expect(@share.constructor.init).toHaveBeenCalled()
        expect(@share._fb_ui).toHaveBeenCalled()

  describe "#detect_provider", ->

    it "expect call detect provider for auto provider", ->
      spyOn(subject.prototype, "detect_provider").andCallThrough()
      @share = new subject(@fb_fixture.full)
      expect(subject.prototype.detect_provider).toHaveBeenCalled()

    it "expect not detect provider for defined provider", ->
      spyOn(subject.prototype, "detect_provider")

      @share = new subject(@fb_fixture.sharer)
      expect(@share.detect_provider).not.toHaveBeenCalled()

    it "expect to receive sharer provider for iOS Chrome browser", ->
      @share = new subject(@fb_fixture.sharer)
      ios_chrome_agent = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 5_1_1 like Mac OS X; en) AppleWebKit/534.46.0 (KHTML, like Gecko) CriOS/19.0.1084.60 Mobile/9B206 Safari/7534.48.3"
      spyOn(@share, "_user_agent").andReturn ios_chrome_agent

      expect(@share.detect_provider()).toBe "sharer"

    it "expect to receive fb_ui provider for sharing with app_id params", ->
      @share = new subject(@fb_fixture.fb_ui)
      expect(@share.app_id).toBeDefined()
      expect(@share.detect_provider()).toBe "fb_ui"

    it "expect to receive dialog provider for sharing with app_id and return url params", ->
      @share = new subject(@fb_fixture.returned)
      expect(@share.app_id).toBeDefined()
      expect(@share.return_url).toBeDefined()
      expect(@share.detect_provider()).toBe "dialog"

    it "expect to receive fb_ui provider for sharing with app_id params", ->
      delete @fb_fixture.partial.provider
      @share = new subject(@fb_fixture.partial)
      expect(@share.detect_provider()).toBe "sharer"

    it "expect to receive fb_ui provider for sharing with app_id params", ->
      delete @fb_fixture.partial.provider
      @share = new subject(@fb_fixture.partial)
      expect(@share.detect_provider()).toBe "sharer"

