class @SharingTags.BaseShare

  url: null
  title: null
  description: null

  constructor: ({@url, @title, @description})->
    unless @url && @title && @description
      throw new SharingTags.Error("Error could not initialize sharing class, with params:#{ " #{arg}: '#{val}'" for arg, val of arguments[0]}")

  open_popup: ->

class @SharingTags.FacebookShare extends @SharingTags.BaseShare

  # available providers: sharer, fb_ui, dialog
  @default_provider: "fb_ui"
  @provider: "fb_ui"

  app_id:     null
  return_url: null
  provider:   null

  constructor: ({@app_id, @return_url, @provider})->
    super

  share: ()->

  sharer: ->
    #    @open_popup("http://www.facebook.com/sharer.php", u: @url)

  fb_ui: ->

  dialog: ->


  # call trigger

