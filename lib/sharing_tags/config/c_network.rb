require 'uri'

module SharingTags
  class Config
    class CNetwork
      # TODO: add default values

      AVAILABLE_NETWORKS = %i( facebook google twitter vkontakte odnoklassniki line linkedin )

      ATTRIBUTES =
          %i( share_url title description  page_url share_url_params link_params
          image_url image  )

      # @@available_attributes = ATTRIBUTES.dup

      attr_reader :name, :attributes

      class Error < ::SharingTags::Config::CError
      end

      def self.lists
        AVAILABLE_NETWORKS
      end

      def initialize(name, context = nil)
        @name = name
        @context = context
        @running_context = SharingTags::Network::RunningContext.new(self, context)

        @c_context = context
        @s_context = context.share_context

        @network = network_class.new(name, self)

        @s_context[name]||= @network # add network to context

        clear!
      end

      def clear!
        @attributes = {}
      end

      def self.available_attributes
        ATTRIBUTES
      end

      def self.assign_to_network attribute, aliases = []
        # @@available_attributes << attribute
        # puts [@@available_attributes, self.inspect].inspect
        define_method attribute, ->(value = nil, &block) do
          @network.assign attribute, value, &block
        end
      end

      assign_to_network :title
      assign_to_network :description
      assign_to_network :share_url
      assign_to_network :page_url
      assign_to_network :share_url_params


      #
      # def share_url(url = nil, &block)
      #   @network.assign(:share_url, url, &block)
      # end
      #
      # def title(new_title = nil, &block)
      #   @network.assign(:title, new_title, &block)
      # end
      #
      # def description(value = nil, &block)
      #   @network.assign(:description, value, &block)
      # end

      # TODO: activate rubycop Metrics
      # rubocop:disable Metrics/AbcSize
      # image_url(new_image = nil, size = nil, content_type = nil, options, &block)
      def image_url(*arguments, &block)
        options = arguments.extract_options!
        new_image, size, content_type = arguments

        # TODO: add another class for storing image
        attributes[:image] = store_value(new_image, &block)
        @network.image = store_value(new_image, &block)

        # add size and content type for block value
        size, content_type = new_image, size if block_given?

        attributes[:image_size] = store_value(size.split("x").map(&:to_i)) if size
        attributes[:image_content_type] = store_value(content_type) if content_type
      end
      alias_method :image, :image_url
      # rubocop:enable Metrics/AbcSize

      # TODO: add image_size
      # TODO: add_image_type

      # def page_url(new_url = nil, &block)
      #   @network.assign(:page_url, new_url, &block)
      # end

      # def share_url_params(params = nil, &block)
      #   @network.assign(:share_url_params, params, &block)
      # end
      alias_method :link_params, :share_url_params

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

      def network_class
        SharingTags::Network
      end

      def store_value(val, &block)
        if block_given?
          block
        else
          val
        end
      end

      def get_value(value, context_params)
        if value.is_a?(Proc)
          if @context && @running_context
            # execute proc within the view context with context_params
            @running_context.instance_exec(*context_params, &value)
          else
            value.call(context_params)
          end
        else
          value
        end
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