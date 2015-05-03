#=require sharing_tags/share
#=require sharing_tags/share/base
#=require sharing_tags/share/vkontakte

fixture.preload("vkontakte.json")

describe "SharingTags.VkontakteShare", ->

  subject = SharingTags.VkontakteShare

  beforeEach ->
    @vk_fixture = fixture.load("vkontakte.json")[0]

  it "expect defined class", ->
    expect( SharingTags ).toBeDefined()
    expect( SharingTags.VkontakteShare ).toBeDefined()

  describe "#share", ->
    beforeEach ->
      @vk = @vk_fixture.full
      @share = new subject(@vk)

    it "expect open popup", ->
      spyOn(@share, "_open_popup")

      @share.share()
      expect(@share._open_popup).toHaveBeenCalled()
      expect(@share._open_popup).toHaveBeenCalledWith(
        "http://vk.com/share.php",
        jasmine.objectContaining(url: @vk.url, image: @vk.image, title: @vk.title, description: @vk.description)
      )
