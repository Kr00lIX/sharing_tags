module SharingTags
  class Config
    class CNetworkFacebook < CNetwork
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