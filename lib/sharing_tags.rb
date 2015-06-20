require "slim-rails"
require "role-rails"

module SharingTags
  autoload :VERSION,        'sharing_tags/version'
  autoload :Config,         'sharing_tags/config'
  autoload :Configuration,  'sharing_tags/configuration'
  autoload :Network,        'sharing_tags/network'
  autoload :Context,        'sharing_tags/context'

  autoload :AssetFile,        'sharing_tags/asset_file'
  autoload :FindsAssetPaths,  'sharing_tags/finds_asset_paths'

  module ActionView
    autoload :MetaHelper,   'sharing_tags/action_view/meta_helper'
    autoload :ButtonHelper, 'sharing_tags/action_view/button_helper'
    autoload :AssetHelper,  'sharing_tags/action_view/asset_helper'
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
    @config ||= Configuration.new
  end
  module_function :config
end

require 'sharing_tags/railtie' if defined?(Rails::Railtie)
require 'sharing_tags/engine' if defined?(Rails)
