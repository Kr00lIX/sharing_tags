
module SharingTags
  class Config
    class CNetworkDefault < CNetwork
      protected

      def parent(network_name)
        return unless @context.main_context
        @context.main_context[network_name] || @context.main_context.default_network
      end
    end
  end
end