class @SharingTags.FacebookShare extends @SharingTags.BaseShare

  # available providers: sharer, fb_ui, dialog
  @default_provider: "fb_ui"

  app_id:     null
  return_url: null
  provider:   null

  constructor: ({@app_id, @return_url, @provider})->
    @provider = @detect_provider() if !@provider || @provider == "auto"

    # todo: throw error for invalid provider
    @constructor.init() if @provider is 'fb_ui' and not FB?

    super

  @init: (locale="en_US")->
    if not FB?
      jQuery.ajax(
        url: "//connect.facebook.net/#{locale}/all.js"
        dataType: "script"
        cache: true
      )

  share: (provider = @provider)->
    @_before_callback(provider)
    @["_#{provider}"]()

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

  # @note: mobile chrome and android browsers after sharing redirect to created post on Facebook
  # @note: iphone facebook browser: after sharing redirected to shared post
  _stream_share: ->
    @_assert_vars 'url'
    FB.ui(
      method: 'stream.share',
      u: @url
      (response) ->
        console?.log response
    )

#  # @note: iphone facebook browser - doesn't show page after sharing
#  _fb_ui_feed = ->
#    FB.ui(
#      method: 'feed',
#      name: "Name"
#      description: "Description"
#      link: @url,
#      caption: "Sample caption",
#      actions: {name: 'sample name', link: 'sharing link'},
#      (response)=>
#        @_after_callback(response)
#    )

  detect_provider: ->
    if @_user_agent().match('CriOS')
      "sharer"
    else if @app_id
      if @return_url then "dialog"
      else "fb_ui"
    else
      "sharer"
