module SharingTags
  class NetworkRunningContext
    def initialize(network, context)
      @network_name = network.name
      @context = context
      @context_name = @context.name
    end

    def network
      @network_name
    end

    def context
      @context_name
    end

    def method_missing(method_name, *arguments, &block)
      return unless @context && @context.config
      @context.config.running_context.send(method_name, *arguments, &block)
    end
  end
end