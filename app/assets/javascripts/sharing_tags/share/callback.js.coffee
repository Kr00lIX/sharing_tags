class @SharingTags.Share.Callback
  constructor: (@share)->
    @network = @share.network
    @context = @share.context

  before_sharing: (provider)=>
    @trigger("start_share", url: @share.url, provider: provider, network: @network, context: @context)

  after_sharing: (response)->
    @trigger("shared", response: response, network: @network, context: @context)

  before_open_popup: (open_url, popup_window)=>
    @trigger("open_popup", url: open_url, popup_window: popup_window)

  trigger: (trigger_name, params...)->
    jQuery?(window).trigger("sharing_tags.#{trigger_name}", params)
