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

      it "expect desktop version", ->
        SharingTags.share('vkontakte')
        expect(SharingTags.Share.vkontakte).toHaveBeenCalled()

