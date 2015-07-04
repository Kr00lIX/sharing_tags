module SharingTags
  class ShareContext < ConfigStorage

    ## ref to parent context

    ## todo iterable? each by each network

    def initialize(config_context, parent_context = nil)
      @config_context = config_context
      # @running_context = SharingTags::Network::RunningContext.new(self, context)
      @context_params = nil
      @networks = {}
    end

    def [](network)
      @networks[network]
    end

    def []=(network, value)
      @networks[network] = value
    end

    # def add_network(name)
    #   # @networks[name] = SharingTags::Network.new(name, self)
    # end

    def twitter
      @networks[:twitter]
    end

    ## assign context params
    ## storage for networks
    ##

  end
end