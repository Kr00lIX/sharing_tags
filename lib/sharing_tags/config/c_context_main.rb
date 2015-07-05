module SharingTags
  class Config
    # Main context called on first configuration level
    #
    class CContextMain < CContext
      attr_reader :network_list

      def initialize(*args)
        @network_list = CNetwork::AVAILABLE_NETWORKS
        super
      end

      # define used networks
      def networks(*networks)
        @network_list = networks

        networks.each do |network|
          unless CNetwork::AVAILABLE_NETWORKS.include?(network)
            fail Config::CError, "Error sharing_tags network configuration. Network #{network} is unavailable. Please chose one of existing networks: #{CNetwork::AVAILABLE_NETWORKS.inspect} "
          end
        end
      end

      # def language(language)
      #   @language = language
      # end
    end
  end
end
