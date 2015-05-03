class @SharingTags.VkontakteShare extends @SharingTags.BaseShare

  constructor: ({@url, @title, @description, @image})->
    super

  share: ->
    @_open_popup(
      "http://vk.com/share.php",
      url: @url,
      title: @title,
      description: @description,
      image: @image
    )
