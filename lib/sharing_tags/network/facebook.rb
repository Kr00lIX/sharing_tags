module SharingTags
  class Network
    class Facebook < Network
      def self.available_attributes
        super + %i( app_id provider )
      end

      def provider(provider = 'auto', &block)
        attributes[:provider] = store_value(provider, &block)
      end

      def app_id(app_id = nil, &block)
        attributes[:app_id] = store_value(app_id, &block)
      end
    end
  end
end