module SharingTags
  class Railtie < Rails::Railtie

    # config.eager_load_namespaces << SharingTags

    generators do
      require "generators/sharing_tags/install/install_generator"
    end

    # rake_tasks do
    #   load "rspec/rails/tasks/rspec.rake"
    # end

    initializer "sharing_tags.configure_view_controller" do |app|
      ActiveSupport.on_load :action_view do
        include SharingTags::ActionView::MetaHelper
        include SharingTags::ActionView::AssetHelper
        include SharingTags::ActionView::ButtonHelper
      end

      ActiveSupport.on_load :action_controller do
        include SharingTags::ActionController::Helpers
        include SharingTags::ActionController::Filters
      end
    end

  end
end