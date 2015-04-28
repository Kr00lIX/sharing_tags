module SharingTags::ActionView::ButtonHelper

  def sharing_tags_buttons(*networks)
    options = networks.extract_options!
    networks = SharingTags::Network.lists if networks.empty?
    # todo: add params for switching context
    render template: "sharing_tags/buttons", locals: {networks: networks, options: options}
  end

  def link_to_facebook_share(name_or_options = nil, &block)
    share_link_to name_or_options, :facebook, [:app_id], &block
  end

  def link_to_vkontakte_share(name_or_options = nil, &block)
    share_link_to name_or_options, :vkontakte, [:title, :description, :image], &block
  end

  def link_to_google_share(name_or_options = nil, &block)
    share_link_to name_or_options, :google, [], &block
  end

  def link_to_odnoklassniki_share(name_or_options = nil, &block)
    share_link_to name_or_options, :odnoklassniki, [:title, :description], &block
  end

  def link_to_twitter_share(name_or_options = nil, &block)
    share_link_to name_or_options, :twitter, [:title, :description], &block
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
      name_or_options = default_name(network) if name_or_options.nil?

      link_to name_or_options, params.page_url, data: data_attrs, role: "sharing_tags_share", target: "_blank", &block
    end
  end

  def default_name(network)
    image_tag "sharing_tags/icons/#{network}.svg"
  end

end