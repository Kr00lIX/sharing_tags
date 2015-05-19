module SharingTags
  # = Sharing Tags Railtie
  class Railtie < Rails::Railtie # :nodoc:

    generators do
      require "generators/sharing_tags/install/install_generator"
    end

    initializer "sharing_tags.configure_view_controller" do
      ActiveSupport.on_load :action_view do
        include SharingTags::ActionView::MetaHelper
        include SharingTags::ActionView::ButtonHelper

        # @note: load AssetHelper after sprockets helper
        include Sprockets::Rails::Helper if defined?(Sprockets::Rails::Helper) && !include?(Sprockets::Rails::Helper)
        include SharingTags::ActionView::AssetHelper
      end

      ActiveSupport.on_load :action_controller do
        include SharingTags::ActionController::Helpers
        include SharingTags::ActionController::Filters
      end
    end

    console do
      ApplicationController.new.view_context
    end
  end
end
