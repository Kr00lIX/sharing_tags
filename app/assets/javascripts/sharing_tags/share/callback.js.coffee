class @SharingTags.Share.Callback
  constructor: (@share)->

  before_sharing: (provider)=>
    @trigger("start_share", url: @share.url, provider: provider)

  after_sharing: ->
    @trigger("shared")

  before_open_popup: (open_url, popup_window)=>
    @trigger("open_popup", url: open_url, popup_window: popup_window)

  trigger: (trigger_name, params...)->
    jQuery?(window).trigger("sharing_tags.#{trigger_name}", params)
