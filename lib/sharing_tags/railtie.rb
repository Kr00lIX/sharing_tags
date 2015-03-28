module SharingTags
  class Railtie < Rails::Railtie

    # config.eager_load_namespaces << SharingTags

    initializer "sharing_tags.configure_view_controller" do |app|
      ActiveSupport.on_load :action_view do
        include SharingTags::ActionView::Helpers
      end

      ActiveSupport.on_load :action_controller do
        include SharingTags::ActionController::Helpers
      end
    end

  end
end