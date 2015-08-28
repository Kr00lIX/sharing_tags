
$(document).on 'click', "@sharing_tags_share", (event) ->
  event.preventDefault()
  self = $(@)

  share = SharingTags.share(
    self.data('network'),
    page_url:    self.attr 'href'
    url:         self.data 'share-url'
    title:       self.data 'title'
    description: self.data 'description'
    image:       self.data 'image'
    app_id:      self.data 'app-id'
    provider:    self.data 'provider'
    caption:     self.data 'caption'
    context:     self.data 'context'
    message:     self.data 'description' # @note deprecated
  )

  share.callback.click_action(target: self)