require 'rails/generators'

# rubocop:disable Metrics/MethodLength
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
        if File.exist?("config/initializers/sharing_tags.rb")
          say_skipped("create initializer sharing_tags.rb")
        else
          template 'initializer.rb', 'config/initializers/sharing_tags.rb'
        end
      end

      def add_javascripts
        source_file = "app/assets/javascripts/application.js"
        match_string = "sharing_tags"

        insert_into_file_if source_file, match_string, after: /\z/ do
          "\n//= require #{match_string}"
        end
      end

      def add_styles
        source_file = "app/assets/stylesheets/application.css"

        match_string = "sharing_tags"
        insert_into_file_if source_file, "#{match_string}\n", before: "*/" do
          "*= require #{match_string}\n "
        end

        match_string = "sharing_tags/icons"
        insert_into_file_if source_file, match_string, before: "*/" do
          "*= require #{match_string}\n "
        end
      end
      
      def add_layout
        ## slim
        source_file = "app/views/layouts/application.html.slim"
        render_meta_tags = "render_sharing_tags"
        buttons_tags = "sharing_tags_buttons"

        insert_into_file_if(source_file, render_meta_tags, before: "body") do
          "  \n    = #{render_meta_tags}\n\n  "
        end

        insert_into_file_if(source_file, buttons_tags, after: "body") do
          "\n    = #{buttons_tags}\n"
        end

        ## erb
        source_file = "app/views/layouts/application.html.erb"
        insert_into_file_if(source_file, render_meta_tags, before: "</head>") do
          "  <%= #{render_meta_tags} %>\n"
        end

        insert_into_file_if(source_file, buttons_tags, after: "<body>") do
          "\n  <%= #{buttons_tags} %>\n"
        end

        ## TODO: haml
      end

      def display_post_install
        readme "POST_INSTALL" if behavior == :invoke
      end

      private

      def say_skipped(message)
        say_status("skipped", message, :yellow)
      end

      def insert_into_file_if(source_file, find_string, **insert_into_file_options, &insert_into_file_block)
        source_file_path =  File.expand_path(source_file, destination_root)
        return unless File.exist?(source_file_path)

        source_content = File.binread(source_file_path)
        if !source_content.include?(find_string)
          insert_into_file source_file, insert_into_file_options, &insert_into_file_block
        else
          say_skipped("insert #{find_string} into #{source_file}")
        end
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength