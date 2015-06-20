module SharingTags
  class ShareContext < ConfigStorage

    ## ref to parent context

    def initialize(config_context)
      @config_context = config_context
      @networks = {}
    end

    def [](network)
      @networks[network]
    end

    def []=(network, value)
      @networks[network] = value
    end

    def add_network(name)
      # @networks[name] = SharingTags::Network.new(name, self)
    end

    def twitter
      @networks[:twitter]
    end

    ## assign context params
    ## storage for networks
    ##

  end
end