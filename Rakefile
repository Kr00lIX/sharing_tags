require "bundler/gem_tasks"

# RSpec
# -----------------------------------------------------------------------------
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

# Dummy App
# -----------------------------------------------------------------------------
APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'


# Teaspoon
# -----------------------------------------------------------------------------
require 'teaspoon/environment'
Teaspoon::Environment.require_environment

# Default
# -----------------------------------------------------------------------------
# Rake::Task["default"].prerequisites.clear
# Rake::Task["default"].clear

desc 'Default: Run all specs.'
task test: :spec
task default: :spec
# task default: [:spec, :teaspoon]

