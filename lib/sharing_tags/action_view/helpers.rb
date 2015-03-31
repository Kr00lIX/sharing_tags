module SharingTags::ActionView::Helpers

  def sharing_tags
    SharingTags.config.within_context_params(self)
  end

  def render_sharing_tags
    logger.debug "SharingTags: Render meta tags context=#{SharingTags.config.current_context.name}, params=#{sharing_tags.to_hash.inspect}"
    render template: "sharing_tags/meta_tags"
  end

  def link_to_facebook_share(name = "Facebook")
    share_link_to name, :facebook
  end

  def link_to_vkontakte_share(name = "Vkontakte")
    share_link_to name, :vkontakte, [:title, :description, :image]
  end

  def link_to_odnoklassniki_share(name = "Odnoklassniki")
    share_link_to name, :odnoklassniki, [:title, :description]
  end

  def link_to_twitter_share(name = "Twitter")
    share_link_to name, :twitter, [:title, :description]
  end

  private

  def share_link_to(name, network, data_params = [])
    params = sharing_tags[network]
    data_attrs = params.get *(data_params +[:network, :share_url])

    link_to name, params.page_url, data: data_attrs, role: "sharing_tags_share", target: "_blank"
  end

end