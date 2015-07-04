module SharingTags
  class Config
    class CNetworkTwitter < CNetwork
      @available_attributes = []

      def self.available_attributes
        super + @available_attributes
      end

      assign_to_network :domain
      assign_to_network :site
      assign_to_network :creator
      assign_to_network :card
      # assign_to_network :summary


      protected

      def self.network_class
        SharingTags::Network::Twitter
      end
    end
  end
end