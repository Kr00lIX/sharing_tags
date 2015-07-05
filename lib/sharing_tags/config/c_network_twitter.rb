module SharingTags
  class Config
    class CNetworkTwitter < CNetwork
      assign_to_network :domain
      assign_to_network :site
      assign_to_network :creator
      assign_to_network :card

      def self.network_class
        SharingTags::Network::Twitter
      end
    end
  end
end