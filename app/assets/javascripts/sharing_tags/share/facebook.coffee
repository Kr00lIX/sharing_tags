class @SharingTags.BaseShare

  url: null
  title: null
  description: null

  constructor: ({@url, @title, @description})->
    @_assert_vars 'url'

  _open_popup: (api_url, params)->
    share_url = if params then "#{api_url}?#{$.param(params)}" else api_url
    share_window = window.open share_url, 'Sharing', 'width=740,height=440'

    clearInterval(@interval)
    iteration = 0
    @interval = setInterval((=>
      iteration++
      if @_checkSharing(share_url, share_window, iteration)
        clearInterval @interval
        jQuery("body").trigger("sharing_tags.shared") if jQuery
    ), 500)

  _checkSharing: (share_url, share_window, iteration)=>
    # console.log("check desktop sharing", share_url, share_window, iteration)
    share_window?.closed || iteration >= 15

  _after_callback: =>
    jQuery?("body").trigger("sharing_tags.shared")

  _assert_vars: (vars...)->
    for var_name in vars
      if ! @[var_name]
        arguments_list = ''
        arguments_list += " #{var_name}: '#{@[var_name]}'" for arg, val in vars
        throw new SharingTags.Error("Error could not initialize sharing class, with params: #{arguments_list}")

class @SharingTags.FacebookShare extends @SharingTags.BaseShare

  # available providers: sharer, fb_ui, dialog
  @default_provider: "fb_ui"

  app_id:     null
  return_url: null
  provider:   null

  constructor: ({@app_id, @return_url, @provider})->
    @provider = @_detect_provider() if !@provider

    # todo: throw error for invalid provider
    @constructor.init() if not FB? if @provider is 'fb_ui'

    super

  @init: (locale="en_US")->
    if not FB?
      jQuery.ajax(
        url: "//connect.facebook.net/#{locale}/all.js"
        dataType: "script"
        cache: true
      )

  share: ()->
    @["_#{@provider}"]()

  _sharer: ->
    @_assert_vars "url"
    @_open_popup("http://www.facebook.com/sharer.php", u: @url)

  _fb_ui: =>
    @_assert_vars "url", "app_id"
    return @constructor.init().done(@_fb_ui) if not FB?

    FB?.ui(method: 'share', href: @url, app_id: @app_id, (response)=>
      @_after_callback(response)
      # if response && !response.error_code
      #  @_after_callback(response)
      # else
      #  # another callback
    )

  _dialog: (display = 'page')->
    @_assert_vars 'url', 'return_url'
    @_open_popup("http://www.facebook.com/dialog/share", href: @url, redirect_uri: @return_url, app_id: @app_id, display: display)


  _detect_provider: ->
    # todo: detect provider by params
    # try fb_ui url, app_id
    # try dialog  url, return_url
    # try sharer  url

    @constructor.default_provider