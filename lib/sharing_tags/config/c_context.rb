module SharingTags
  class Config
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

        # define context network getter
        ShareContext.define_network(name)
      end

      define_network :twitter,  Config::CNetworkTwitter, alias_name: :tw
      define_network :facebook, Config::CNetworkFacebook, alias_name: :fb
      define_network :google, alias_name: :gl
      define_network :vkontakte, alias_name: :vk
      define_network :line, alias_name: :ln
      define_network :odnoklassniki, alias_name: :od
      define_network :linkedin, alias_name: :li

      def default_network
        @default_network ||= CNetworkDefault.new(:default, self)
      end

      private

      def method_missing(method_name, *arguments, &block)
        unless default_network.class.available_attributes.include?(method_name.to_sym)
          fail CNetwork::Error, "Error didn't find #{method_name} attribute in network. Available attributes: #{default_network.class.available_attributes.to_s(", ")}"
        end
        default_network.send(method_name, *arguments, &block)
      end
    end
  end
end