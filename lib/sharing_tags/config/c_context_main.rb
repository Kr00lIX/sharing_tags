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

      # define using networks
      def networks(*network_list)
        network_list.each do |network|
          unless CNetwork::AVAILABLE_NETWORKS.include?(network)
            fail Config::CError, "Error sharing_tags network configuration. Network #{network} is unavailable. Please chose one of existing networks: #{CNetwork::AVAILABLE_NETWORKS.join(", ")} "
          end
        end
        config.networks = Array(network_list)
      end

      def language(lang)
        config.language = lang
      end
    end
  end
end
