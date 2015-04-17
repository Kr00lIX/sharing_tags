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

    it "expect error if init without title", ->
      delete @fb_partial.title
      expect(=> new subject(@fb_partial)).toThrow(SharingTags.Error(), /Error could not initialize sharing class/)

    it "expect error if init without description", ->
      delete @fb_partial.description
      expect(=> new subject(@fb_partial)).toThrow(SharingTags.Error(), /Error could not initialize sharing class/)

  describe "share provider", ->
    it "expect use default provider"
    it "expect change default provider"
    it "expect change provider on initialize"


  describe "callback", ->
    it "set global callback"
    it "set callback with initializer"

  describe "events", ->
    it "expect trigger event start sharing"
    it "expect trigger event after sharing"

#  describe "mobile version", ->
#    beforeEach ->
#      spyOn(SharingTags.MobileShare, "_share")
#      spyOn(SharingTags.Share, "_share")
#
#    it "expect call share mobile version when app_id defined", ->
#      share_params = url: "share url", return_url: "return url", app_id: "app id"
#      callback = -> "callback"
#      SharingTags.MobileShare.facebook(share_params, callback)
#      expect(SharingTags.MobileShare._share).toHaveBeenCalled()
#      expect(SharingTags.MobileShare._share).toHaveBeenCalledWith("http://www.facebook.com/dialog/share", href: "share url", redirect_uri: "return url", app_id: "app id", display: 'touch', callback)
#
##    it "expect call share desktop version without app_id", ->
##      SharingTags.MobileShare.facebook(url: "share_url")
##      expect(SharingTags.Share._share).toHaveBeenCalled()
##      expect(SharingTags.MobileShare._share).toHaveBeenCalled()
##      spyOn(SharingTags.MobileShare, "_share")
#
