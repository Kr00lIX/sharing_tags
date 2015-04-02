class @SharingTags

  @share: (network, attributes, callback)->
    SharingTags.Share[network]?(attributes, callback)

  class @Share

    @facebook: ({url}, callback) ->
      @_share("http://www.facebook.com/sharer.php", u: url, callback)

    @twitter: ({url, message}, callback) ->
      @_share("http://twitter.com/intent/tweet", text: message, url: url, callback)

    @vkontakte: ({title, url, message, image}, callback) ->
      @_share('http://vk.com/share.php',
        url: url,
        title: title,
        description: message,
        image: image,
        callback
      )

    @google: ({url}, callback) ->
      @_share("https://plus.google.com/share", url: url, callback)

    @odnoklassniki: ({url, message}, callback) ->
      @_share("http://www.odnoklassniki.ru/dk",
        'st._surl': url, 'st.comments': message, 'st.cmd': 'addShare', 'st.s': 1, callback)

    @mailru: ({url, title, image, message}, callback) ->
      @_share('http://connect.mail.ru/share', url: url, title: title, description: message, imageurl: image, callback)

    @linkedin: ({url, title, message}, callback) ->
      @_share('http://www.linkedin.com/shareArticle?mini=true',
        url: url, title: title, summary: message,
        callback
      )

    @_share: (api_url, params, callback) ->
      share_url = if params then "#{api_url}?#{$.param(params)}" else api_url
      share_window = window.open share_url, 'Sharing', 'width=740,height=440'

      clearInterval(@interval)
      @interval = setInterval((=>
        if share_window.closed
          clearInterval @interval
          callback() if callback
      ), 500)
