module SharingTags::ActionView::Helpers

  def sharing_tags
    SharingTags.config.within_context_params(self)
  end

  def render_sharing_tags
    logger.debug "SharingTags: Render meta tags context=#{SharingTags.config.current_context.name}, params=#{sharing_tags.to_hash.inspect}"
    render template: "sharing_tags/meta_tags"
  end

  def link_to_facebook_share(name = "Facebook", &block)
    share_link_to name, :facebook, [], &block
  end

  def link_to_vkontakte_share(name = "Vkontakte", &block)
    share_link_to name, :vkontakte, [:title, :description, :image], &block
  end

  def link_to_odnoklassniki_share(name = "Odnoklassniki", &block)
    share_link_to name, :odnoklassniki, [:title, :description], &block
  end

  def link_to_twitter_share(name = "Twitter", &block)
    share_link_to name, :twitter, [:title, :description], &block
  end

  private

  def share_link_to(name_or_options = nil, network = nil, data_params = [], &block)
    params = sharing_tags[network]
    data_attrs = params.get(*(data_params +[:network, :share_url]))

    if block_given?
      name_or_options = {} if !name_or_options || name_or_options.is_a?(String)
      data_attrs.merge!(name_or_options.delete(:data)) if name_or_options[:data]

      if name_or_options[:role]
        name_or_options[:role] += " sharing_tags_share"
      else
        name_or_options[:role] = "sharing_tags_share"
      end

      name_or_options.merge!(data: data_attrs, target: "_blank")

      link_to params.page_url, name_or_options, &block
    else
      link_to name_or_options, params.page_url, data: data_attrs, role: "sharing_tags_share", target: "_blank", &block
    end
  end

end