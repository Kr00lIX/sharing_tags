
module SharingTags
  class Config
    class CNetworkDefault < CNetwork
      protected

      def parent        
        @context.main_context[network_name] if @context.main_context
      end
    end
  end
end