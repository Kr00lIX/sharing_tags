#=require sharing_tags/share

fixture.preload("vkontakte.json")

xdescribe "SharingTags.VkontakteShare", ->

#  subject = SharingTags.VkontakteShare
#
#  beforeEach ->
#    @vk_fixture = fixture.load("vkontakte.json")[0]
#
#  it "expect defined class", ->
#    expect( SharingTags ).toBeDefined()
#    expect( SharingTags.VkontakteShare ).toBeDefined()
#
#  describe "#share", ->
#    beforeEach ->
#      @vk = @vk_fixture.full
#      @share = new subject(@vk)
#
#    it "expect open popup", ->
#      spyOn(@share, "share_popup")
#
#      @share.share()
#      expect(@share.share_popup).toHaveBeenCalled()
#      expect(@share.share_popup).toHaveBeenCalledWith(
#        "http://vk.com/share.php",
#        jasmine.objectContaining(url: @vk.url, image: @vk.image, title: @vk.title, description: @vk.description)
#      )
