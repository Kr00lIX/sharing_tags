'use strict'

class @SharingTags

  @debug: false

  @share: (network, attributes = {})->
    attributes.network = network
    SharingTags.Share[network]?(attributes)

  class @Error extends Error
    constructor: -> super

  class @Share

    @line: ({title, url, context, network}) ->
      message = "#{title} #{url}"
      @share_popup(
        network: "line"
        url: url
        popup_url: "http://line.me/R/msg/text/?#{encodeURIComponent(message)}"
        popup_params: null
        network: network
        context: context
      )

    @facebook: ({url, app_id, caption, title, description, image, return_url, provider, network}) ->
      @_debug("Facebook sharing", arguments[0])
      (new SharingTags.FacebookShare(arguments[0])).share()

    @twitter: ({url, title, context, network}) ->
      @share_popup(
        url: url
        popup_url: "http://twitter.com/intent/tweet"
        popup_params:
          text: title
          url: url
        network: network
        context: context
      )

    @vkontakte: ({title, url, description, image, context, network}) ->
      @share_popup(
        url: url
        popup_url: "http://vk.com/share.php"
        popup_params:
          url: url
          title: title
          description: description
          image: image
        network: network
        context: context
      )

    @google: ({url, context, network}) ->
      @share_popup(
        url: url
        popup_url: "https://plus.google.com/share"
        popup_params: {url: url}
        network: network
        context: context
      )

    @odnoklassniki: ({url, description, context, network}) ->
      @share_popup(
        url: url
        popup_url: "http://www.odnoklassniki.ru/dk"
        popup_params: {'st._surl': url, 'st.comments': description, 'st.cmd': 'addShare', 'st.s': 1}
        network: network
        context: context
      )

    @mailru: ({url, title, image, description, context, network}) ->
      @share_popup(
        url: url
        popup_url: 'http://connect.mail.ru/share'
        popup_params: {url: url, title: title, description: description, imageurl: image}
        network: network
        context: context
      )

    @linkedin: ({url, title, description, context, network}) ->
      @share_popup(
        url: url
        popup_url: 'http://www.linkedin.com/shareArticle'
        popup_params: {mini: true, url: url, title: title, summary: description}
        network: network
        context: context
      )

    @share_popup: ({network, url, popup_url, popup_params})->
      social_share = new Share(arguments[0])
      social_share.open_popup(popup_url, popup_params)
      social_share

    @_debug: (args...)->
      console?.debug(args...) if SharingTags.debug

    constructor: ({@network, @context, @url, @title, @description, @image})->
      @_assert_vars 'url'
      @callback = new SharingTags.Share.Callback(@)
      @constructor._debug("Init sharing #{@network}", {@url, @title, @description})

    open_popup: (api_url, params, popup_attrs = 'width=550,height=420,toolbar=no')->
      share_url = if params then "#{api_url}?#{$.param(params)}" else api_url

#      popup_attrs =
#        case @network
#          when "twitter" then "width=550,height=420,toolbar=no"
#          when "google"   then "menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600"
#          when "facebook" then "width=550,height=420,toolbar=no"
#          when "vkontakte" then "width=550,height=420,toolbar=no"

      share_window = window.open share_url, 'Sharing', popup_attrs
      @callback.open_popup(share_url, share_window)

      clearInterval(@interval)
      iteration = 0
      @interval = setInterval((=>
        iteration++
        if @_open_popup_check(share_url, share_window, iteration)
          clearInterval @interval
          @callback.success_share()
          @callback.after_share()
      ), 500)

    _open_popup_check: (share_url, share_window, iteration)=>
      # console.log("check desktop sharing", share_url, share_window, iteration)
      share_window?.closed || iteration >= 10

    _assert_vars: (vars...)->
      for var_name in vars
        if ! @[var_name]
          arguments_list = ''
          arguments_list += " #{var_name}: '#{@[var_name]}'" for arg, val in vars
          throw new SharingTags.Error("Error could not initialize sharing class, with params: #{arguments_list}")

    _user_agent: ->
      window.navigator?.userAgent

    _prepare_params: (params)->
      result = {}
      result[key] = value for key, value of params when value? and  value != ""
      result
