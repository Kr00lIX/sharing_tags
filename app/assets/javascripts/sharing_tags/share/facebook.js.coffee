class @SharingTags.FacebookShare extends @SharingTags.Share

  # available providers: sharer, fb_ui, dialog
  @default_provider: "fb_ui"

  app_id:     null
  return_url: null
  provider:   null

  constructor: ({@app_id, @caption, @return_url, @provider})->
    @provider = @detect_provider() if !@provider || @provider == "auto"

    # todo: throw error for invalid provider
    @constructor.init() if @provider is 'fb_ui' and not FB?

    super

  # facebook locales support (https://www.facebook.com/translations/FacebookLocales.xml)
  #
  @init: (locale="en_US")->

    # todo: for debug mode load debug sdk
    # js.src = "//connect.facebook.net/en_US/sdk/debug.js";
    if not FB?
      sdk_url = locale + (if @debug then "/sdk/debug.js" else "/all.js")

      `(function(d, s, id){
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) {return;}
      js = d.createElement(s); js.id = id;
      js.src = "http://connect.facebook.net/" + sdk_url;
      fjs.parentNode.insertBefore(js, fjs);
      }(document, 'script', 'facebook-jssdk'));`

  share: (provider = @provider)->
    @callback.before_sharing(provider)
    @["_#{provider}"]()
    @

  _sharer: ->
    @_assert_vars "url"
    @open_popup("http://www.facebook.com/sharer.php", u: @url)

  #   https://developers.facebook.com/docs/javascript/reference/FB.ui
  _fb_ui: =>
    @_assert_vars "url", "app_id"
    FB?.ui(
      method: 'share',
      href: @url,
      (response)=>
        @callback.after_sharing(response)
        # if response && !response.error_code
        #  @_after_callback(response)
        # else
        #  # another callback
    )

  _dialog: (display = 'page')->
    @_assert_vars 'url', 'return_url'
    @open_popup("http://www.facebook.com/dialog/share", href: @url, redirect_uri: @return_url, app_id: @app_id, display: display)

  # @note: mobile chrome and android browsers after sharing redirect to created post on Facebook
  # @note: iphone facebook browser: after sharing redirected to shared post
  _stream_share: ->
    @_assert_vars 'url'
    FB.ui(
      method: 'stream.share',
      u:       @url
      (response) ->
        @callback.after_sharing(response)
    )

  # @note: iphone facebook browser - doesn't redirect to page after sharing
  # @note: android browser - Ok
  # return post_id
  # https://developers.facebook.com/docs/sharing/reference/feed-dialog/v2.3
  _fb_ui_feed: =>
    FB.ui(
      method:      'feed'
      link:         @url
      name:         @caption # The name of the link attachment.
      caption:      @title
      description:  @description
      picture:      @image
      redirect_uri: @return_url
      (response)=>
        @callback.after_sharing(response)
    )

  detect_provider: ->
    provider =
      if @_user_agent().match('CriOS')
        "sharer"
      else if @app_id
        if @return_url then "dialog"
        else "fb_ui_feed"
      else
        "sharer"
    @constructor._debug("Facebook#detect_provider", provider)
    provider
