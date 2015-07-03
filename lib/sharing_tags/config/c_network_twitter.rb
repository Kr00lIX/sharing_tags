module SharingTags
  class Config
    class CNetworkTwitter < CNetwork
      def self.available_attributes
        super + %i( domain site creator card)
      end

      assign_to_network :domain
      assign_to_network :site
      assign_to_network :creator
      assign_to_network :card


      protected

      def network_class
        SharingTags::Network::Twitter
      end
    end
  end
end