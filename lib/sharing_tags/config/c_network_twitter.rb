module SharingTags
  class Config
    class CNetworkTwitter < CNetwork
      def self.available_attributes
        super + %i( domain site creator card)
      end



    end
  end
end