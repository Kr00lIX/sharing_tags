module  SharingTags
  class Context

    attr_reader :name
    attr_reader :configuraton

    def initialize(name, configuraton)
      @name = name
      @networks = {}
      @configuraton = configuraton

      Network.lists.each do |name|
        self.send(name)
      end
    end

    def [](network)
      @networks[network]
    end

    def twitter(&block)
      (@networks[:twitter] ||=  Network.new(:twitter, self)).tap do |twitter|
        twitter.instance_exec(&block) if block_given?
      end
    end

    def facebook(&block)
      (@networks[:facebook] ||=  Network::Facebook.new(:facebook, self)).tap do |facebook|
        facebook.instance_exec(&block) if block_given?
      end
    end

    def google(&block)
      (@networks[:google] ||=  Network.new(:google, self)).tap do |google|
        google.instance_exec(&block) if block_given?
      end
    end

    def vkontakte(&block)
      (@networks[:vkontakte] ||=  Network.new(:vkontakte, self)).tap do |vkontakte|
        vkontakte.instance_exec(&block) if block_given?
      end
    end

    def params(context_args = nil, default_config_params = Config.new)
      @context_params = fetch_params(context_args, default_config_params)
    end

    def default_network
      @default_network ||= Network.new(:default, self)
    end

    private

    def fetch_params(context_args = nil, default_config_params = Config.new)
      default_context_params = fetch_default_context_params(context_args, default_config_params || Config.new)

      @networks.inject(Config.new) do |result, (name, network)|
        param = (result[name] ||= Config.new)

        default_network_params = default_context_params[name]
        param.deep_update network.attributes_for(context_args, default_network_params)

        result[name] = param
        result
      end
    end

    def fetch_default_context_params(context_args = nil, default_config_params = Config.new)
      config_network_defaults = default_config_params && default_config_params.dup || Config.new
      config_network_defaults = default_config_params
      context_default_params =  Config.new

      # todo: context_default_params, config_network_defaults = default_config_params.divide_by { |network, _| Network.lists.include?(network) }

      # divide networks_default_params into to groups default network params and context params
      Network.lists.each do |network|
        context_default_params[network] =
          if config_network_defaults.key?(network)
             config_network_defaults.delete(network)
          else
             Config.new
          end
      end


      context_network_defaults = default_network.attributes_for(context_args, config_network_defaults)

      context_default_params.each_value do |params|
        params.deep_update(context_network_defaults)
      end

      context_default_params
    end

    def method_missing(method_name, *arguments, &block)
      unless default_network.class.available_attributes.include?(method_name.to_sym)
        raise Network::Error.new("Error didn't find #{method_name} attribute in network")
      end
      default_network.send(method_name, *arguments, &block)
    end

  end
end