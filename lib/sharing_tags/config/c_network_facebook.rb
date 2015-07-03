module SharingTags
  class Config
    class CNetworkFacebook < CNetwork
      def self.available_attributes
        super + %i( app_id caption provider return_url)
      end

      assign_to_network :app_id
      assign_to_network :caption
      assign_to_network :provider
      assign_to_network :return_url


      protected

      def self.network_class
        SharingTags::Network::Facebook
      end
    end
  end
end