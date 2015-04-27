class @SharingTags.BaseShare

  url: null
  title: null
  description: null

  constructor: ({@url, @title, @description})->
    unless @url && @title && @description
      throw new SharingTags.Error("Error could not initialize sharing class, with params:#{ " #{arg}: '#{val}'" for arg, val of arguments[0]}")

  _open_popup: (api_url, params)->
    share_url = if params then "#{api_url}?#{$.param(params)}" else api_url
    share_window = window.open share_url, 'Sharing', 'width=740,height=440'

    clearInterval(@interval)
    iteration = 0
    @interval = setInterval((=>
      iteration++
      if @_checkSharing(share_url, share_window, iteration)
        clearInterval @interval
        callback() if callback
        $.trigger("sharing_tags.shared")
    ), 500)

  _checkSharing: (share_url, share_window, iteration)=>
    # console.log("check desktop sharing", share_url, share_window, iteration)
    share_window?.closed || iteration >= 15


class @SharingTags.FacebookShare extends @SharingTags.BaseShare

  # available providers: sharer, fb_ui, dialog
  @default_provider: "fb_ui"
  @provider: "fb_ui"

  app_id:     null
  return_url: null
  provider:   null

  constructor: ({@app_id, @return_url, @provider})->
    super

  @share: ()->
    # todo: call sharing method for choised provider
    @_sharer()

  _sharer: ->
    @_open_popup("http://www.facebook.com/sharer.php", u: @url)

  _fb_ui: =>
    return @_load_fb_ui().done(@_fb_ui) if !FB?
    console.log "fb ui"
    FB?.ui(
      method: 'share',
      href: @url
    )

  _dialog: (display = 'page')->
    @_open_popup("http://www.facebook.com/dialog/share", href: @url, redirect_uri: @return_url, app_id: @app_id, display: display)

  _load_fb_ui: ->
    jQuery.ajax(
      url: '//connect.facebook.net/en_US/all.js'
      dataType: "script"
      cache: true
    ).done =>
      console.log "done 1", @app_id
      FB.init(
        appId:    @app_id,
        version: 'v2.3'
      )

