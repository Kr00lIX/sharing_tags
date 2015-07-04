module SharingTags
  class Config
    class CNetworkFacebook < CNetwork

      @available_attributes = []

      def self.available_attributes
        super + @available_attributes
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