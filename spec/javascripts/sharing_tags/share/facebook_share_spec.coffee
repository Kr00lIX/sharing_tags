#=require sharing_tags/share
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
      @share = new subject(@fb_fixture.full)
      expect(@share.provider).toBe "fb_ui"

    it "expect change provider to sharer on initialize", ->
      @share = new subject(@fb_fixture.sharer)
      expect(@share.provider).toBe "sharer"

  describe "events", ->
    it "expect trigger event start sharing"
    it "expect trigger event after sharing"

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
        expect(FB.ui).toHaveBeenCalledWith jasmine.objectContaining(href: @fb.url, method: 'share')

      it "expect error if init without url", ->
        delete @share.url
        expect(=> @share._fb_ui()).toThrow(SharingTags.Error(), /Error could not initialize sharing class/)

    describe "loading FB.ui", ->
      beforeEach ->
        spyOn(@share, "_load_fb_ui").andCallThrough()
        spyOn(@share, "_fb_ui").andCallThrough()

      it "expect load FB.ui if FB undefined", ->
        expect(typeof FB).toBe('undefined')

        @share._fb_ui()
        expect(@share._load_fb_ui).toHaveBeenCalled()
        expect(@share._fb_ui).toHaveBeenCalled()
#        expect(FB.init).toHaveBeenCalledWith jasmine.objectContaining(app_id: @fb.app_id, version: 'v2.3')
