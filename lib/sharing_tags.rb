require "slim-rails"
require "role-rails"

module SharingTags
  autoload :VERSION,        'sharing_tags/version'
  autoload :ConfigStorage,  'sharing_tags/config_storage'
  autoload :Network,        'sharing_tags/network'
  autoload :Image,          'sharing_tags/image'
  autoload :ShareContext,   'sharing_tags/share_context'
  autoload :Config,         'sharing_tags/config'

  class Network
    autoload :RunningContext,  'sharing_tags/network/running_context'
    autoload :Facebook,        'sharing_tags/network/facebook'
  end

  class Config
    autoload :CError,            'sharing_tags/config/c_error'
    autoload :CContext,          'sharing_tags/config/c_context'
    autoload :CMainContext,      'sharing_tags/config/c_main_context'
    autoload :CNetwork,          'sharing_tags/config/c_network'
    autoload :CDefaultNetwork,   'sharing_tags/config/c_default_network'
    autoload :CNetworkFacebook,  'sharing_tags/config/c_network_facebook'
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
