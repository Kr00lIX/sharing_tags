#=require sharing_tags/share
#=require sharing_tags/share/facebook
#=require sharing_tags/share/callback

fixture.preload("facebook.json")

describe "SharingTags.Share.Callback", ->

  subject = SharingTags.Share.Callback

  beforeEach ->
    @fb_fixture = fixture.load("facebook.json")[0]
    @fb = @fb_fixture.fb_ui
    @share =  new SharingTags.Share @fb
    @callback = new subject(@share)


  it "expect get network and context attr from share", ->
    expect( @callback.network ).toBe "facebook"

  # todo: check all callbacks