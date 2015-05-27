#=require jquery
#=require sharing_tags/share

describe "SharingTags.Share", ->

  subject = SharingTags.Share

  describe "facebook", ->
    fb_share_prototype = SharingTags.FacebookShare.prototype

    beforeEach ->
      @fb_fixture = fixture.load("facebook.json")[0]
      @fb = @fb_fixture.full
      window.FB = jasmine.createSpyObj "FB", ['ui', 'init']

    it "expect init new class with params", ->
      spyOn(fb_share_prototype, 'detect_provider').andCallThrough()
      spyOn(fb_share_prototype, 'share').andCallThrough()

      @share = subject.facebook(@fb)
      expect(fb_share_prototype.detect_provider).toHaveBeenCalled()
      expect(fb_share_prototype.share).toHaveBeenCalled() # for this attributes

      expect(@share.provider).toBe("dialog")
      expect(@share.app_id).toBe(@fb.app_id)
      expect(@share.url).toBe(@fb.url)
      expect(@share.return_url).toBe(@fb.return_url)

    it "expect call sharing method", ->
      spyOn(fb_share_prototype, "share")
      @share = subject.facebook(@fb)
      expect(fb_share_prototype.share).toHaveBeenCalled()


#  describe "vkontakte", ->

#    it "vkontakte"
#    it "facebook"
#    it "twitter"
#    it "google"
#    it "odnoklassniki"
#    it "mailru"
#    it "linkedin"
#    it "line"

