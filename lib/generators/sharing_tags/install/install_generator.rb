require 'rails/generators'

module SharingTags
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      desc "Installs the SharingTags initializer into your application."

      class_option :partials,
                   type: :boolean,
                   aliases: "-p",
                   default: false,
                   desc: "Copy links partial"

      def copy_initializer_file

        if File.exists?("config/initializers/sharing_tags.rb")
          say_skipped("create initializer sharing_tags.rb")
        else
          template 'initializer.rb', 'config/initializers/sharing_tags.rb'
        end
      end

      def add_javascripts
        source_file = "app/assets/javascripts/application.js"
        skip_js = false

        # todo: move to method
        if File.exists? source_file
          original_js = File.binread(source_file)

          update_application_js = ->(source) do
            if original_js.include?(source)
              skip_js = true
            else
              insert_into_file source_file, "\n//= require '#{source}'", :after => %r{\Z}
            end
          end

          update_application_js["sharing_tags/share"]
          update_application_js["sharing_tags/links"]
        else
          skip_js = true
        end

        say_skipped("insert into #{source_file}") if skip_js
      end

      def add_styles
        source_file = "app/assets/stylesheets/application.css"

        if File.exists? source_file
          insert_into_file source_file, :before => "*/" do
            "\n *= require 'sharing_tags'\n\n"
          end
        else
          say_skipped("insert into #{source_file}")
        end
      end

      def add_layout
        # todo add = render_sharing_tags to head
        # and add = sharing_tags_buttons to body
      end

      def display_post_install
        readme "POST_INSTALL" if behavior == :invoke
      end

      private

      def say_skipped(message)
        say_status("skipped", message, :yellow)
      end
    end
  end
end