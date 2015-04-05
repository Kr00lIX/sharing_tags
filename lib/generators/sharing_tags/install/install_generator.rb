require 'rails/generators'

module SharingTags
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def copy_initializer_file
        template 'initializer.rb', 'config/initializers/sharing_tags.rb'
      end

      # todo: add javascript files to applications.js
      # todo add styles application.css

    end
  end
end