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

        @share_context = ShareContext.new(self)
        init_networks(main_context.network_list) if main_context
      end

      def [](network)
        @networks[network]
      end

      def twitter(&block)
        (@networks[:twitter] ||= Config::CNetwork.new(:twitter, self)).tap do |twitter|
          twitter.instance_exec(&block) if block_given?
        end
      end
      alias_method :tw, :twitter

      def facebook(&block)
        (@networks[:facebook] ||= Config::CNetworkFacebook.new(:facebook, self)).tap do |facebook|
          facebook.instance_exec(&block) if block_given?
        end
      end
      alias_method :fb, :facebook

      def google(&block)
        (@networks[:google] ||= Config::CNetwork.new(:google, self)).tap do |google|
          google.instance_exec(&block) if block_given?
        end
      end
      alias_method :gl, :google

      def vkontakte(&block)
        (@networks[:vkontakte] ||= CNetwork.new(:vkontakte, self)).tap do |vkontakte|
          vkontakte.instance_exec(&block) if block_given?
        end
      end
      alias_method :vk, :vkontakte

      def line(&block)
        (@networks[:line] ||= CNetwork.new(:line, self)).tap do |line|
          line.instance_exec(&block) if block_given?
        end
      end
      alias_method :ln, :line

      def odnoklassniki(&block)
        (@networks[:odnoklassniki] ||= CNetwork.new(:odnoklassniki, self)).tap do |odnoklassniki|
          odnoklassniki.instance_exec(&block) if block_given?
        end
      end
      alias_method :ok, :odnoklassniki

      def linkedin(&block)
        (@networks[:linkedin] ||= CNetwork.new(:linkedin, self)).tap do |vkontakte|
          vkontakte.instance_exec(&block) if block_given?
        end
      end
      alias_method :li, :linkedin

      def params(context_args = nil, default_config_params = ConfigStorage.new)
        @context_params = fetch_params(context_args, default_config_params)
      end

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

      def fetch_params(context_args = nil, default_config_params = ConfigStorage.new)
        main_context_params = fetch_main_context_params(context_args, default_config_params || ConfigStorage.new)

        @networks.each_with_object(ConfigStorage.new) do |(name, network), result|
          param = (result[name] ||= ConfigStorage.new)

          default_network_params = main_context_params[name]
          param.deep_update network.attributes_for(context_args, default_network_params)

          result[name] = param
        end
      end

      def fetch_main_context_params(context_args = nil, default_config_params = ConfigStorage.new)
        # divide networks_default_params into to groups default network params and context params
        context_default_params, config_network_defaults = default_config_params.divide_by_keys(CNetwork.lists)

        context_network_defaults = default_network.attributes_for(context_args, config_network_defaults)

        context_default_params.each_value do |params|
          params.deep_update(context_network_defaults)
        end

        context_default_params
      end

      def method_missing(method_name, *arguments, &block)
        unless default_network.class.available_attributes.include?(method_name.to_sym)
          fail CNetwork::Error, "Error didn't find #{method_name} attribute in network"
        end
        default_network.send(method_name, *arguments, &block)
      end
    end
  end
end