module SharingTags
  class Network
    class RunningContext
      def initialize(network, context)
        @network_name = network.name
        @context = context
        @context_name = @context.name
        @config = SharingTags.config
      end

      def network
        @network_name
      end

      def context
        @context_name
      end

      def method_missing(method_name, *arguments, &block)
        return unless @config.running_context
        @config.running_context.send(method_name, *arguments, &block)
      end
    end  
  end
end