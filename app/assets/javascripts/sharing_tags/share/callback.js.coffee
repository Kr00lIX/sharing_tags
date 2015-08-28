class @SharingTags.Share.Callback
  constructor: (@share)->
    @network = @share.network
    @context = @share.context

  click_action: (params)=>
    @trigger("click_action", params)

  before_share: (provider)=>
    @trigger("before_share", provider: provider)

  success_share: (response)->
    @trigger("success_share", response: response)

  cancel_share: (response)->
    @trigger("cancel_share", response: response)

  after_share: (response)->
    @trigger("after_share", response: response)

  open_popup: (open_url, popup_window)=>
    @trigger("open_popup", url: open_url, popup_window: popup_window)

  trigger: (trigger_name, params...)->
    params['type'] = "sharing_tags.#{trigger_name}"
    trigger_params = @_share_params(params)
    jQuery?(window).trigger(trigger_params)
    jQuery?(document).trigger(trigger_params)

  _share_params: (params)->
    properties = {
      url: @share.url
      network: @network
      context: @context
    }
    params[key] = val for key, val of properties
    params
