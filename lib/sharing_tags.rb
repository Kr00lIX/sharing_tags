require "slim-rails"
require "role-rails"

module SharingTags
  autoload :VERSION,        'sharing_tags/version'
  autoload :ConfigStorage,  'sharing_tags/config_storage'
  autoload :Network,        'sharing_tags/network'
  autoload :Image,          'sharing_tags/image'
  autoload :Config,         'sharing_tags/config'
  autoload :ShareContext,   'sharing_tags/share_context'
  autoload :NetworkRunningContext,  'sharing_tags/network_running_context'

  class Config
    autoload :ConfigError,            'sharing_tags/config/config_error'
    autoload :ConfigContext,          'sharing_tags/config/config_context'
    autoload :ConfigMainContext,      'sharing_tags/config/config_main_context'

    autoload :ConfigNetwork,          'sharing_tags/config/config_network'
    autoload :ConfigNetworkFacebook,  'sharing_tags/config/config_network_facebook'
  end

  autoload :AssetFile,        'sharing_tags/asset_file'
  autoload :FindsAssetPaths,  'sharing_tags/finds_asset_paths'

  module ActionView
    autoload :MetaHelper,   'sharing_tags/action_view/meta_helper'
    autoload :ButtonHelper, 'sharing_tags/action_view/button_helper'
  end

  module ActionController
    autoload :Helpers, 'sharing_tags/action_controller/helpers'
    autoload :Filters, 'sharing_tags/action_controller/filters'
  end

  def configure(&block)
    config.clear! # cleanup config before calling configure
    config.instance_exec(&block)
  end
  module_function :configure

  def config
    @config ||= Config.new
  end
  module_function :config
end

require 'sharing_tags/railtie' if defined?(Rails::Railtie)
require 'sharing_tags/engine' if defined?(Rails)
