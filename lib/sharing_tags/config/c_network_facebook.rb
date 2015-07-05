module SharingTags
  class Config
    class CNetworkFacebook < CNetwork
      NETWORK_ATTRIBUTES = %i(app_id caption return_url provider return_url)

      @available_attributes = []

      def self.available_attributes
        super + @available_attributes
      end

      assign_to_network :app_id
      assign_to_network :caption
      assign_to_network :provider
      assign_to_network :return_url

      def self.network_class
        SharingTags::Network::Facebook
      end
    end
  end
end