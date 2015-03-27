require "sharing_tags/engine"

module SharingTags

  #extend ActiveSupport::Autoload

  autoload :VERSION,        'sharing_tags/version'
  autoload :Config,         'sharing_tags/config'
  autoload :Configuration,  'sharing_tags/configuration'
  autoload :Network,        'sharing_tags/network'
  autoload :Context,        'sharing_tags/context'
  autoload :MetaHelper,     'sharing_tags/helpers/meta_helper'

  def configure(&block)
    config.clear! # cleanup config before calling configure
    config.instance_exec(&block)
  end
  module_function :configure

  def config
    @config ||= Configuration.new
  end
  module_function :config

  ActiveSupport.on_load(:action_view) do
    include ::SharingTags::MetaHelper
  end

end
