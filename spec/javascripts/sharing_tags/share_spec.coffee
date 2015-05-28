#=require jquery
#=require sharing_tags/share

describe "SharingTags.Share", ->

  subject = SharingTags.Share
  subject_proto = subject.prototype

  beforeEach ->
    spyOn(subject, "share_popup").andCallThrough()
    spyOn(subject_proto, "open_popup").andCallThrough()

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

      @share = subject.vkontakte(@f)

    it "expect valid open popup url", ->
      expect(subject.share_popup).toHaveBeenCalled()

      api_url = "http://vk.com/share.php"
      params = {
        url: @f.url,
        title: @f.title,
        description: @f.description,
        image: @f.image
      }
      expect(subject_proto.open_popup).toHaveBeenCalledWith(
        api_url, jasmine.objectContaining(params)
      )

    it "expect init new class with params", ->
      expect(@share.network).toBe("vkontakte")
      expect(@share.url).toBe(@f.url)

  describe "twitter", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

      @share = subject.twitter(@f)

    it "expect valid open popup url", ->
      expect(subject.share_popup).toHaveBeenCalled()

      api_url = "http://twitter.com/intent/tweet"
      params = {
        url: @f.url
        text: @f.title
      }
      expect(subject_proto.open_popup).toHaveBeenCalledWith(
        api_url, jasmine.objectContaining(params)
      )

    it "expect init new class with params", ->
      expect(@share.network).toBe("twitter")
      expect(@share.url).toBe(@f.url)
#      expect(@share.title).toBe(@f.title)

  describe "google", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

      @share = subject.google(@f)

    it "expect valid open popup url", ->
      expect(subject.share_popup).toHaveBeenCalled()
      expect(subject_proto.open_popup).toHaveBeenCalledWith(
        "https://plus.google.com/share",
        url: @f.url
      )

    it "expect init new class with params", ->
      expect(@share.network).toBe("google")
      expect(@share.url).toBe(@f.url)

  describe "odnoklassniki", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

      @share = subject.odnoklassniki(@f)

    it "expect valid open popup url and params", ->
      expect(subject.share_popup).toHaveBeenCalled()
      expect(subject_proto.open_popup).toHaveBeenCalledWith(
        "http://www.odnoklassniki.ru/dk",
        jasmine.objectContaining
          'st._surl': @f.url
          'st.comments': @f.description
          'st.cmd': 'addShare'
          'st.s': 1
      )

    it "expect init new class with params", ->
      expect(@share.network).toBe("odnoklassniki")
      expect(@share.url).toBe(@f.url)

  describe "mailru", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

      @share = subject.mailru(@f)

    it "expect valid open popup url", ->
      expect(subject.share_popup).toHaveBeenCalled()
      expect(subject_proto.open_popup).toHaveBeenCalledWith(
        "http://connect.mail.ru/share",
        jasmine.objectContaining
          url: @f.url
          title: @f.title
          description: @f.description
          imageurl: @f.image
      )

    it "expect init new class with params", ->
      expect(@share.network).toBe("mailru")
      expect(@share.url).toBe(@f.url)

  describe "linkedin", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

      @share = subject.linkedin(@f)

    it "expect valid open popup url", ->
      expect(subject.share_popup).toHaveBeenCalled()
      expect(subject_proto.open_popup).toHaveBeenCalledWith(
        "http://www.linkedin.com/shareArticle",
        jasmine.objectContaining
          url: @f.url
          title: @f.title
          summary: @f.description
          mini: true
      )

    it "expect init new class with params", ->
      expect(@share.network).toBe("linkedin")
      expect(@share.url).toBe(@f.url)

  describe "line", ->
    beforeEach ->
      @fixture = fixture.load("vkontakte.json")[0]
      @f = @fixture.full

      @share = subject.line(@f)

    it "expect valid open popup url", ->
      message = "#{@f.title} #{@f.url}"
      expect(subject.share_popup).toHaveBeenCalled()
      expect(subject_proto.open_popup).toHaveBeenCalledWith(
        "http://line.me/R/msg/text/?#{encodeURIComponent(message)}",
        null
      )

    it "expect init new class with params", ->
      expect(@share.network).toBe("line")
      expect(@share.url).toBe(@f.url)


  xdescribe "#_open_popup_check"
  xdescribe "#open_popup"