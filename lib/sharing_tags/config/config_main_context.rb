module SharingTags
  class Config

    # Main context called on first configuration level
    #
    class ConfigMainContext < ConfigContext
      attr_reader :network_list

      def initialize(*args)
        @network_list = ConfigNetwork::AVAILABLE_NETWORKS
        super
      end

      # define used networks
      def networks(*networks)
        @network_list = networks

        networks.each do |network|
          unless ConfigNetwork::AVAILABLE_NETWORKS.include?(network)
            raise Config::ConfigError.new("Error sharing_tags network configuration. Network #{network} is unavailable. Please chose one of existing networks: #{ConfigNetwork::AVAILABLE_NETWORKS.inspect} ")
          end
        end
        init_networks(network_list)
      end

      def language(language)
        @language = language
      end
    end
  end
end
