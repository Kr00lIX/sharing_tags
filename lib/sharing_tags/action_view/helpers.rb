module SharingTags::ActionView::Helpers

  def sharing_tags
    SharingTags.config.within_context_params(self)
  end

  def render_sharing_tags
    logger.debug "SharingTags: Render meta tags context=#{SharingTags.config.current_context.name}, params=#{sharing_tags.to_hash.inspect}"
    render template: "sharing_tags/meta_tags"
  end

end