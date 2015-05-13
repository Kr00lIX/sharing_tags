module SharingTags
  module ActionController
    module Filters
      extend ActiveSupport::Concern

      included do
        append_before_filter :sharing_tags_clear_context
      end

      def sharing_tags_clear_context
        logger.debug "SharingTags: clear context #{SharingTags.config.current_context.name}!" if logger.debug?
        SharingTags.config.clear_context!
      end
    end
  end
end    