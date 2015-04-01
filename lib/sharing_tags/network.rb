module SharingTags
  class Network

    class Error < StandardError
    end

    NETWORKS = %i( facebook google twitter vkontakte odnoklassniki )

    ATTRIBUTES = %i( share_url title description image_url image page_url share_url_params link_params )

    attr_reader :name, :attributes

    autoload :Facebook,   'sharing_tags/network/facebook'

    def self.lists
      NETWORKS
    end

    def initialize(name, context = nil)
      @name = name
      @context = context
      @attributes = {}
      @share_url_params = nil
    end

    def self.available_attributes
      ATTRIBUTES
    end

    def share_url(url = nil, &block)
      attributes[:share_url] = store_value(url, &block)
    end

    def title(new_title = nil, &block)
      attributes[:title] = store_value(new_title, &block)
    end

    def description(value = nil, &block)
      attributes[:description] = store_value(value, &block)
    end

    def image_url(new_image = nil, size = nil, content_type = nil, &block)
      attributes[:image] = store_value(new_image, &block)

      # add size and content type for block value
      size, content_type = new_image, size if block_given?

      attributes[:image_size] = store_value(size.split("x"), &block) if size
      attributes[:image_content_type] = store_value(content_type, &block) if content_type
    end
    alias :image :image_url

    def page_url(new_url = nil, &block)
      attributes[:page_url] = store_value(new_url, &block)
    end

    def share_url_params(params = nil, &block)
      @share_url_params = store_value(params, &block)
    end
    alias :link_params :share_url_params

    def attributes_for(context_params = nil, default_params = Config.new)
      # todo: merge default params after get all values of attributes
      @attributes.inject(default_params.dup) do |result, (name, value)|
        result[name] = get_value(value, context_params)
        result
      end.tap do |attrs|
        #todo: fix assign share_url from page_url
        attrs[:share_url] = attrs[:page_url].dup if !attrs[:share_url] && attrs[:page_url]
        attrs[:share_url] = ("#{attrs[:share_url]}?" + @share_url_params.to_query) if attrs[:share_url] && @share_url_params

        attrs[:network] = name if attrs.present?
      end
    end

    protected

    def store_value(val, &block)
      if block_given?
        block
      else
        val
      end
    end

    def get_value(value, context_params)
      if value.is_a?(Proc)
        if running_context = @context.configuraton.running_context
          # execute proc within the view context with context_params
          running_context.instance_exec(*context_params, &value)
        else
          value.call(context_params)
        end
      else
        value
      end
    end
  end
end