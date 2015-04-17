#=require jquery
#=require sharing_tags/share

describe "Sharing Tags", ->

  it "expect defined class", ->
    expect( SharingTags ).toBeDefined()
    expect( SharingTags.share ).toBeDefined()

  describe ".share", ->
    beforeEach ->

    describe "facebook", ->
      beforeEach ->
        spyOn(SharingTags.Share, "facebook")
        spyOn(SharingTags.MobileShare, "facebook")

      it "expect mobile version", ->
        SharingTags.share('facebook', mobile: true, url: "url")
        expect(SharingTags.MobileShare.facebook).toHaveBeenCalled()

      it "expect desktop version", ->
        SharingTags.share('facebook')
        expect(SharingTags.Share.facebook).toHaveBeenCalled()

#    it "vkontakte"
#    it "twitter"
#    it "google"
#    it "odnoklassniki"
#    it "mailru"
#    it "linkedin"

