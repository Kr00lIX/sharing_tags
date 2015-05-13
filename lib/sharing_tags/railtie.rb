module SharingTags
  # = Sharing Tags Railtie
  class Railtie < Rails::Railtie # :nodoc:
    config.eager_load_namespaces << SharingTags

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

    # initializer "sharing_tags.reload_initializer_hook", group: :all do |app|
    #
    #   # callback = lambda do
    #   #   ActiveSupport::DescendantsTracker.clear
    #   #   ActiveSupport::Dependencies.clear
    #   # end
    #   # if config.reload_classes_only_on_change
    #     puts "-"*100
    #     puts "self reloaders"
    #     puts reloaders.inspect
    #
    #     # reloader = config.file_watcher.new(*watchable_args, &callback)
    #     # self.reloaders << reloader
    #     # ActionDispatch::Reloader.to_prepare(prepend: true) do
    #     #   reloader.execute
    #     # end
    #   # else
    #   #   puts "="*100
    #   #   ActionDispatch::Reloader.to_cleanup(&callback)
    #   # end
    # end

    # Add a to_prepare block which is executed once in production
    # and before each request in development
    config.to_prepare do
    end

    console do
      ApplicationController.new.view_context
    end
  end
end
