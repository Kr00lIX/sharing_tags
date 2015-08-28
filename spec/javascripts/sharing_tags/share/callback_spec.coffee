#=require sharing_tags/share
#=require sharing_tags/share/facebook
#=require sharing_tags/share/callback

fixture.preload("facebook.json")

describe "SharingTags.Share.Callback", ->

  subject = SharingTags.Share.Callback

  beforeEach ->
    @fb_fixture = fixture.load("facebook.json")[0]
    @fb = @fb_fixture.fb_ui
    @fb.context = "callback context"
    @share =  new SharingTags.Share @fb
    @callback = new subject(@share)

  it "expect get network and context attr from share", ->
    expect( @callback.network ).toBe "facebook"

  it "expect get context and context attr from share", ->
    expect( @callback.context ).toBe "callback context"

  describe "callbacks", ->
    beforeEach ->
      spyOn(@callback, "trigger")
      @response = jasmine.createSpy('response')

    it "#click_action", ->
      @callback.click_action(target: "target_object")
      expect(@callback.trigger).toHaveBeenCalledWith(
        "click_action", jasmine.objectContaining(target: "target_object")
      )

    it "#before_share", ->
      @callback.before_share("auto")
      expect(@callback.trigger).toHaveBeenCalledWith(
        "before_share", jasmine.objectContaining(provider: "auto")
      )

    it "#success_share", ->
      @callback.success_share(@response)
      expect(@callback.trigger).toHaveBeenCalledWith(
        "success_share", jasmine.objectContaining(response: @response)
      )

    it "#cancel_share", ->
      @callback.cancel_share(@response)
      expect(@callback.trigger).toHaveBeenCalledWith(
        "cancel_share", jasmine.objectContaining(response: @response)
      )

    it "#after_share", ->
      @callback.after_share(@response)
      expect(@callback.trigger).toHaveBeenCalledWith(
        "after_share", jasmine.objectContaining(response: @response)
      )

    it "open_popup", ->
      window_obj = jasmine.createSpy('window')
      @callback.open_popup("url", window_obj)
      expect(@callback.trigger).toHaveBeenCalledWith(
        "open_popup", jasmine.objectContaining(
          url: "url", popup_window: window_obj
        )
      )

  describe "#trigger", ->
    beforeEach ->
      @original_jquery = window.jQuery
#      spyOn(jQuery(window), "trigger")
      window.jQuery = jasmine.createSpyObj('jQuery', ['trigger'])

    afterEach ->
      window.jQuery = @original_jquery

    xit "expect valid trigger params", ->
      @callback.trigger("callback_name", {param1: "val1", param2: "val2"})
      expect(jQuery(window).trigger).toHaveBeenCalledWith(
        "sharing_tags.callback_name", jasmine.objectContaining(
          param1: "val1", param2: "val2"
        )
      )
