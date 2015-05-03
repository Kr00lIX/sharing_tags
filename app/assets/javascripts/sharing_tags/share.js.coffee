class @SharingTags

  @share: (network, attributes, callback)->
    share_object = if attributes?.mobile then SharingTags.MobileShare else SharingTags.Share
    share_object[network]?(attributes, callback)

  class @Error extends Error
    constructor: -> super

  class @Share

    @facebook: ({url, app_id}, callback) ->
      if app_id
        social_share = new SharingTags.FacebookShare url: url, app_id: app_id
        social_share.share()
      else
        @_share("http://www.facebook.com/sharer.php", u: url, callback)

    @twitter: ({url, message}, callback) ->
      @_share("http://twitter.com/intent/tweet", text: message, url: url, callback)

    @vkontakte: ({title, url, message, image}, callback) ->
      social_share = new SharingTags.VkontakteShare url: url, title: title, description: message, image: image
      social_share.share()

    @google: ({url}, callback) ->
      @_share("https://plus.google.com/share", url: url, callback)

    @odnoklassniki: ({url, message}, callback) ->
      @_share("http://www.odnoklassniki.ru/dk",
        'st._surl': url, 'st.comments': message, 'st.cmd': 'addShare', 'st.s': 1, callback)

    @mailru: ({url, title, image, message}, callback) ->
      @_share('http://connect.mail.ru/share', url: url, title: title, description: message, imageurl: image, callback)

    @linkedin: ({url, title, message}, callback) ->
      @_share('http://www.linkedin.com/shareArticle',
        mini: true, url: url, title: title, summary: message,
        callback
      )

    @_share: (api_url, params, callback) ->
      share_url = if params then "#{api_url}?#{$.param(params)}" else api_url
      share_window = window.open share_url, 'Sharing', 'width=740,height=440'

      clearInterval(@interval)
      iteration = 0
      @interval = setInterval((=>
        iteration++
        if @_checkSharing(share_url, share_window, iteration)
          clearInterval @interval
          callback() if callback
          jQuery?("body").trigger("sharing_tags.shared")
      ), 500)

    @_checkSharing: (share_url, share_window, iteration)=>
      # console.log("check desktop sharing", share_url, share_window, iteration)
      share_window?.closed || iteration >= 15

  class @MobileShare extends @Share

    @facebook: ({url, return_url, app_id}, callback) ->
#      if app_id
#        return_url = url if !return_url
#        @_share("http://www.facebook.com/dialog/share", href: url, redirect_uri: return_url, app_id: app_id, display: 'touch', callback)
#      else
      super

    @twitter: ({title, url, message}, callback) ->
      # todo: fix adding hash tags
      # text = "#{encodeURI(message)}%20%23aviasales%20%23avialove%20#{url}"
#      text = "#{encodeURI(message)}%20#{url}"
#      exportUrl = "twitter://post?message=#{text}"
#      window.location.replace(exportUrl)
#      setTimeout (->
#        @_share("http://twitter.com/intent/tweet", text: message, url: url, callback)
#      ), 1
      super

    @_share: ->
      super

    @_checkSharing: (share_url, share_window, iteration)=>
      # console.log("check mobile sharing", share_url, share_window, iteration)
      return true if iteration >= 1
