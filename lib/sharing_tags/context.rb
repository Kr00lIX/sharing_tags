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

    def params(context_args = nil, default_config_params = Config.new)
      default_network_params = default_network.attributes_for(context_args, default_config_params)

      @networks.inject(Config.new) do |result, (name, network)|
        param = (result[name] ||= Config.new)
        param.deep_update network.attributes_for(context_args, default_network_params)

        result[name] = param
        result
      end
    end

    def method_missing(method_name, *arguments, &block)
      default_network.send(method_name, *arguments, &block)
    end

    def default_network
      @default_network ||= Network.new(:default, self)
    end

  end
end