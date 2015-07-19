module SharingTags
  class ShareContext
    ## ref to parent context
    attr_reader :name
    attr_accessor :context_params

    ## todo iterable? each by each network

    def self.define_network(name)
      define_method name do
        @config_context.send(name) unless @networks.key? name
        @networks[name]
      end
    end

    def initialize(config_context, _parent_context = nil)
      @name = config_context.name
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

    # def method_missing(method_name, *arguments, &block)
    #   current_context.send(method_name, *arguments, &block)
    # end

    ## assign context params
    ## storage for networks
    ##
  end
end