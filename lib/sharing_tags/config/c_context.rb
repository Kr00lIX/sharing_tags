module SharingTags
  class Config
    #
    # Define default values for networks
    #
    class CContext
      attr_reader :name
      attr_reader :config
      attr_reader :share_context

      def initialize(name, config, main_context = nil)
        @name = name
        @networks = {}
        @config = config # @note need for running context
        @main_context = main_context

        @share_context = ShareContext.new(self, main_context.try(:share_context))

        init_networks(main_context.network_list) if main_context
      end

      def [](network)
        @networks[network]
      end

      def self.define_network(name, config_class = SharingTags::Config::CNetwork, alias_name: nil)
        define_method name do |_options = {}, &config_block|
          network = (@networks[name] ||= config_class.new(name, self))
          network.instance_exec(&config_block) if config_block
          network
        end
        alias_method alias_name, name if alias_name
      end

      define_network :twitter,  Config::CNetworkTwitter, alias_name: :tw
      define_network :facebook, Config::CNetworkFacebook, alias_name: :fb
      define_network :google, alias_name: :gl
      define_network :vkontakte, alias_name: :vk
      define_network :line, alias_name: :ln
      define_network :odnoklassniki, alias_name: :od
      define_network :linkedin, alias_name: :li

      # def params(context_args = nil, default_config_params = ConfigStorage.new)
      #   @context_params = fetch_params(context_args, default_config_params)
      # end

      def default_network
        @default_network ||= CDefaultNetwork.new(:default, self)
      end

      protected

      def init_networks(network_list)
        @networks = {}
        network_list.each do |network_name|
          @share_context.add_network network_name
          send(network_name) unless @networks.key?(network_name)
        end
      end

      private

      # def fetch_params(context_args = nil, default_config_params = ConfigStorage.new)
      #   main_context_params = fetch_main_context_params(context_args, default_config_params || ConfigStorage.new)
      #
      #   @networks.each_with_object(ConfigStorage.new) do |(name, network), result|
      #     param = (result[name] ||= ConfigStorage.new)
      #
      #     default_network_params = main_context_params[name]
      #     param.deep_update network.attributes_for(context_args, default_network_params)
      #
      #     result[name] = param
      #   end
      # end
      #
      # def fetch_main_context_params(context_args = nil, default_config_params = ConfigStorage.new)
      #   # divide networks_default_params into to groups default network params and context params
      #   context_default_params, config_network_defaults = default_config_params.divide_by_keys(CNetwork.lists)
      #
      #   context_network_defaults = default_network.attributes_for(context_args, config_network_defaults)
      #
      #   context_default_params.each_value do |params|
      #     params.deep_update(context_network_defaults)
      #   end
      #
      #   context_default_params
      # end

      def method_missing(method_name, *arguments, &block)
        unless default_network.class.available_attributes.include?(method_name.to_sym)
          fail CNetwork::Error, "Error didn't find #{method_name} attribute in network"
        end
        default_network.send(method_name, *arguments, &block)
      end
    end
  end
end