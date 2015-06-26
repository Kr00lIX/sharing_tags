# Generators are not automatically loaded by Rails
require 'generators/sharing_tags/install/install_generator'

describe SharingTags::Generators::InstallGenerator, type: :generator do

  # Tell the generator where to put its output (what it thinks of as Rails.root)
  destination File.expand_path('../../tmp', __FILE__)
  teardown :cleanup_destination_root

  before do
    prepare_destination
  end

  describe 'initializer' do
    before do
      run_generator
    end

    subject { file 'config/initializers/sharing_tags.rb' }

    it "creates a sharing_tags initializer" do
      is_expected.to exist
    end

    it "generates config/initializers/sharing_tags.rb" do
      generator_command_notice = / This file was generated by the `rails generate sharing_tags:install` command./m
      is_expected.to contain(generator_command_notice)
    end

    it "expect has a valid syntax" do
      is_expected.to have_correct_syntax
    end
  end

  describe 'assets:javascripts' do

    describe "application.js" do
      let(:file_path) { "app/assets/javascripts/application.js" }
      subject { file file_path }

      before do
        touch_file file_path
        run_generator
      end

      it "expect added require sharing_tags " do
        generator_command =  '= require sharing_tags'
        is_expected.to contain(generator_command)
      end
    end

    describe "application.coffee" do
      pending
    end
  end

  describe 'assets:stylesheets' do

    describe "application.css" do
      let(:file_path) { "app/assets/stylesheets/application.css" }
      subject { file file_path }

      before do
        create_file file_path, "/**/"
        subject
        run_generator
      end

      it "expect added require sharing_tags " do
        generator_command =  '= require sharing_tags'
        is_expected.to contain(generator_command)
      end
    end

    describe "application.sass" do
      pending
    end

    describe "application.scss" do
      pending
    end
  end

  describe 'view:layouts' do
    let(:file_path) { "app/views/layouts/application.html.slim" }
    subject { file file_path }

    describe "application.html.slim" do
      let(:layout) do 
        %(
        html
          header
            title Some title
          body
            p Text block
        ) 
      end

      before do
        create_file file_path, layout
        run_generator
      end

      it "expect added sharing_meta_tags " do
        generator_command =  '= sharing_meta_tags'
        is_expected.to contain(generator_command)
      end

      # it { is_expected.to have_correct_syntax }
    end

    describe "application.html.erb" do
      before do
        create_file file_path, layout
        run_generator
      end

      subject { file file_path }

      let(:layout) do 
        %(<html>
          <head>
            <title>Some title</title>
          </head>
          <body>
            <p>Text block</p>
          </body>
        </html>) 
      end
      let(:file_path) { "app/views/layouts/application.html.erb" }

      it "expect added render_sharing_tags " do
        generator_command =  '<%= sharing_meta_tags %>'
        is_expected.to contain(generator_command)
      end

      it { is_expected.to have_correct_syntax }
    end

    describe "application.html.haml" do
      pending
    end
  end

  describe "after install" do
    it "expect has a message" do
      # expect { run_generator }.to output(/Congratulations/).to_stderr_from_any_process
      # expect { run_generator }.to output(/Congratulations/).to_stdout_from_any_process
      # expect { run_generator }.to output(/Congratulations/).to_stdout
    end
  end
end



