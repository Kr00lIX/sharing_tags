module SharingTags
  class Network
    class Facebook < Network
      def self.available_attributes
        super + %i( app_id )
      end

      def app_id(app_id = nil, &block)
        attributes[:app_id] = store_value(app_id, &block)
      end
    end
  end
end