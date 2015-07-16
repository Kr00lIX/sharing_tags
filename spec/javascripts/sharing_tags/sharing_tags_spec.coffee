#=require jquery
#=require sharing_tags/share

describe "SharingTags.share", ->

  it "expect defined class", ->
    expect( SharingTags ).toBeDefined()
    expect( SharingTags.share ).toBeDefined()

  describe ".share", ->

    describe "facebook", ->
      beforeEach ->
        spyOn(SharingTags.Share, "facebook")

      it "expect calling", ->
        SharingTags.share('facebook')
        expect(SharingTags.Share.facebook).toHaveBeenCalled()

    describe "vkontakte", ->
      beforeEach ->
        spyOn(SharingTags.Share, "vkontakte")

      it "expect calling", ->
        SharingTags.share('vkontakte')
        expect(SharingTags.Share.vkontakte).toHaveBeenCalled()

    describe "twitter", ->
      beforeEach ->
        spyOn(SharingTags.Share, "twitter")

      it "expect calling", ->
        SharingTags.share('twitter')
        expect(SharingTags.Share.twitter).toHaveBeenCalled()

    describe "line", ->
      beforeEach ->
        spyOn(SharingTags.Share, "line")

      it "expect calling", ->
        SharingTags.share('line')
        expect(SharingTags.Share.line).toHaveBeenCalled()

    describe "google", ->
      beforeEach ->
        spyOn(SharingTags.Share, "google")

      it "expect calling", ->
        SharingTags.share('google')
        expect(SharingTags.Share.google).toHaveBeenCalled()

    describe "odnoklassniki", ->
      beforeEach ->
        spyOn(SharingTags.Share, "odnoklassniki")

      it "expect calling", ->
        SharingTags.share('odnoklassniki')
        expect(SharingTags.Share.odnoklassniki).toHaveBeenCalled()


    describe "linkedin", ->
      beforeEach ->
        spyOn(SharingTags.Share, "linkedin")

      it "expect calling", ->
        SharingTags.share('linkedin')
        expect(SharingTags.Share.linkedin).toHaveBeenCalled()

