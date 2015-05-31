module SharingTags
  class Config
    class ConfigNetworkFacebook < ConfigNetwork
      def self.available_attributes
        super + %i( app_id caption provider return_url)
      end

      def provider(provider = 'auto', &block)
        attributes[:provider] = store_value(provider, &block)
      end

      def app_id(app_id = nil, &block)
        attributes[:app_id] = store_value(app_id, &block)
      end

      def return_url(url = nil, &block)
        attributes[:return_url] = store_value(url, &block)
      end

      def caption(message = nil, &block)
        attributes[:caption] = store_value(message, &block)
      end
    end
  end
end