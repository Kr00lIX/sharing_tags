#=require jquery
#=require sharing_tags/share

describe "SharingTags.Share", ->

  subject = SharingTags.Share

  describe "facebook", ->
    share_prototype = SharingTags.FacebookShare.prototype

    beforeEach ->
      @fb_fixture = fixture.load("facebook.json")[0]
      @fb = @fb_fixture.full
      window.FB = jasmine.createSpyObj "FB", ['ui', 'init']

    it "expect init new class with params", ->
      spyOn(share_prototype, 'detect_provider').andCallThrough()
      spyOn(share_prototype, 'share').andCallThrough()

      @share = subject.facebook(@fb)
      expect(share_prototype.detect_provider).toHaveBeenCalled()
      expect(share_prototype.share).toHaveBeenCalled() # for this attributes

      expect(@share.provider).toBe("dialog")
      expect(@share.app_id).toBe(@fb.app_id)
      expect(@share.url).toBe(@fb.url)
      expect(@share.return_url).toBe(@fb.return_url)

    it "expect call sharing method", ->
      spyOn(share_prototype, "share")
      @share = subject.facebook(@fb)
      expect(share_prototype.share).toHaveBeenCalled()


  describe "vkontakte", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

    it "expect init new class with params", ->
      spyOn(subject, "share_popup")

      subject.vkontakte(@f)

      expect(subject.share_popup).toHaveBeenCalledWith(
        jasmine.objectContaining(url: @f.url)
      )

  describe "twitter", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

    it "expect init new class with params", ->
      spyOn(subject, "share_popup").andCallThrough()

      @share = subject.twitter(@f)

      expect(@share.network).toBe("twitter")
      expect(@share.url).toBe(@f.url)

      expect(subject.share_popup).toHaveBeenCalledWith(
        jasmine.objectContaining(url: @f.url)
      )

  describe "google", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

    it "expect init new class with params", ->
      spyOn(subject, "share_popup").andCallThrough()

      @share = subject.google(@f)
      expect(@share.network).toBe("google")

      expect(subject.share_popup).toHaveBeenCalledWith(
        jasmine.objectContaining(url: @f.url)
      )

  describe "odnoklassniki", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

      spyOn(subject, "share_popup").andCallThrough()
      @share = subject.odnoklassniki(@f)

    it "expect valid open popup url", ->
      expect(subject.share_popup).toHaveBeenCalledWith(
        jasmine.objectContaining(url: @f.url)
      )

    it "expect init new class with params", ->
      expect(@share.network).toBe("odnoklassniki")
      expect(@share.url).toBe(@f.url)


  describe "mailru", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

    it "expect init new class with params", ->
      spyOn(subject, "share_popup").andCallThrough()

      @share = subject.mailru(@f)

      expect(@share.network).toBe("mailru")
      expect(@share.url).toBe(@f.url)

      expect(subject.share_popup).toHaveBeenCalledWith(
        jasmine.objectContaining(url: @f.url)
      )

  describe "linkedin", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

    it "expect init new class with params", ->
      spyOn(subject, "share_popup").andCallThrough()

      @share = subject.linkedin(@f)

      expect(@share.network).toBe("linkedin")
      expect(@share.url).toBe(@f.url)

      expect(subject.share_popup).toHaveBeenCalledWith(
        jasmine.objectContaining(url: @f.url)
      )

  describe "line", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

    it "expect init new class with params", ->
      spyOn(subject, "share_popup").andCallThrough()

      @share = subject.line(@f)

      expect(@share.network).toBe("line")
      expect(@share.url).toBe(@f.url)

      expect(subject.share_popup).toHaveBeenCalledWith(
        jasmine.objectContaining(url: @f.url)
      )

