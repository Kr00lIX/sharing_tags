module SharingTags
  class Engine < ::Rails::Engine
    isolate_namespace SharingTags

    config.assets.precompile += %w( sharing_tags/icons.js )

    if Rails.env.development?
      config.to_prepare do
        init_config = Rails.root.join('config', 'initializers', 'sharing_tags.rb').to_s
        require_dependency init_config if File.exists?(init_config)
      end
    end

    # optional, without it will call `to_prepend` only when a file changes,
    # not on every request
    config.after_initialize do |app|
      app.config.reload_classes_only_on_change = false if Rails.env.development?


      # In default Rails apps, this will be a fully operational
      # Sprockets::Environment instance
      SharingTags.config.asset_finder = app.instance_variable_get(:@assets)
    end

  end
end