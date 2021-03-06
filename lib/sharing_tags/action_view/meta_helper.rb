module SharingTags
  module ActionView
    module MetaHelper
      def sharing_tags
        SharingTags.config.within_context_params(self)
      end

      def render_sharing_tags
        render template: "sharing_tags/meta_tags.html.slim"
      end
      alias_method :sharing_meta_tags, :render_sharing_tags
    end  
  end    
end