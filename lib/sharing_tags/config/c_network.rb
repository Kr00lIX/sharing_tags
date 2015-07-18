require 'uri'

module SharingTags
  class Config
    class CNetwork < CNetworkBase
      assign_to_network :title
      assign_to_network :description
      assign_to_network :share_url
      assign_to_network :page_url
      assign_to_network :share_url_params, aliases: :link_params
      assign_to_network :image_url, aliases: :image

      # # image_url(new_image = nil, size = nil, content_type = nil, options, &block)
      # # def image_url(*arguments, &block)
      # # def image_url(size = nil, content_type = nil, new_image = nil, &image_block)
      def image_url(new_image = nil, &image_block)
        #   # options = arguments.extract_options!
        #   # new_image, size, content_type = arguments
        #

        @network.assign :image_url, new_image, &image_block

        # # add size and content type for block value
        # size, content_type = new_image, size if block_given?
        #
        # attributes[:image_size] = store_value(size.split("x").map(&:to_i)) if size
        # attributes[:image_content_type] = store_value(content_type) if content_type
      end

      # TODO: add image_size
      # TODO: add_image_type

      # def attributes_for(context_params = nil, default_params = ConfigStorage.new)
      #   # TODO: merge default params after get all values of attributes
      #   attrs = @attributes.each_with_object(default_params.dup) do |(a_name, value), result|
      #     result[a_name] = get_value(value, context_params)
      #   end
      #
      #   # TODO: fix assign share_url from page_url
      #   attrs[:share_url] = attrs[:page_url].dup if !attrs[:share_url] && attrs[:page_url]
      #   attrs[:share_url] = add_params_to_url(attrs[:share_url], attrs[:share_url_params]) if attrs[:share_url] && attrs[:share_url_params].present?
      #   attrs[:network] = name if attrs.present?
      #
      #   attrs
      # end

      protected

      def parent(_network_name)
        @context.default_network
      end

      def add_params_to_url(url, params = {})
        return url.html_safe if params.blank?

        uri = URI.parse(url)
        new_params = params.stringify_keys
        exists_params =  URI.decode_www_form(uri.query || '')
        exists_params.delete_if { |k, _|  new_params.key?(k) } # delete existing params
        new_query_array = exists_params + new_params.to_a

        uri.query = URI.encode_www_form(new_query_array)

        uri.to_s.html_safe
      rescue URI::Error
        # TODO: raise error
        url
      end
    end
  end
end