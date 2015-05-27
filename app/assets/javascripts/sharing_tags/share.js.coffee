'use strict'

class @SharingTags

  @share: (network, attributes)->
    SharingTags.Share[network]?(attributes)

  class @Error extends Error
    constructor: -> super

  class @Share

    @line: ({url}) ->
      @share_popup(network: "line", url: url, popup_url: "http://line.me/R/msg/text/?#{encodeURIComponent(url)}")

    @facebook: ({url, app_id, return_url, provider}) ->
      (new SharingTags.FacebookShare(arguments[0])).share()

    @twitter: ({url, title}) ->
      @share_popup(
        network: "twitter"
        url: url
        popup_url: "http://twitter.com/intent/tweet"
        popup_params:
          text: title
          url: url
      )

    @vkontakte: ({title, url, message, image}) ->
      @share_popup(
        network: 'vkontakte'
        url: url,
        popup_url: "http://vk.com/share.php",
        popup_params:
          url: @url,
          title: @title,
          description: @description,
          image: @image
      )

    @google: ({url}) ->
      @share_popup(network: 'google', url: url, popup_url: "https://plus.google.com/share", popup_params: {url: url})

    @odnoklassniki: ({url, message}) ->
      @share_popup(
        network: 'odnoklassniki'
        url: url,
        popup_url: "http://www.odnoklassniki.ru/dk",
        popup_params: {'st._surl': url, 'st.comments': message, 'st.cmd': 'addShare', 'st.s': 1}
      )

    @mailru: ({url, title, image, message}) ->
      @share_popup(
        network: 'mailru'
        url: url,
        popup_url: 'http://connect.mail.ru/share',
        popup_params: {url: url, title: title, description: message, imageurl: image}
      )

    @linkedin: ({url, title, message}) ->
      @share_popup(
        network: 'linkedin'
        url: url,
        popup_url: 'http://www.linkedin.com/shareArticle',
        popup_params: {mini: true, url: url, title: title, summary: message}
      )

    @share_popup: ({network, url, popup_url, popup_params})->
      social_share = new Share(arguments[0])
      social_share.open_popup(popup_url, popup_params)
      social_share

    constructor: ({@network, @url, @title, @description})->
      @_assert_vars 'url'
      @callback = new SharingTags.Share.Callback(@)

    open_popup: (api_url, params)->
      share_url = if params then "#{api_url}?#{$.param(params)}" else api_url
      share_window = window.open share_url, 'Sharing', 'width=740,height=440'
      @callback.before_open_popup(share_url, share_window)

      clearInterval(@interval)
      iteration = 0
      @interval = setInterval((=>
        iteration++
        if @_open_popup_check(share_url, share_window, iteration)
          clearInterval @interval
          @callback.after_sharing()
      ), 500)

    _open_popup_check: (share_url, share_window, iteration)=>
      # console.log("check desktop sharing", share_url, share_window, iteration)
      share_window?.closed || iteration >= 5

    _assert_vars: (vars...)->
      for var_name in vars
        if ! @[var_name]
          arguments_list = ''
          arguments_list += " #{var_name}: '#{@[var_name]}'" for arg, val in vars
          throw new SharingTags.Error("Error could not initialize sharing class, with params: #{arguments_list}")

    _user_agent: ->
      window.navigator?.userAgent
