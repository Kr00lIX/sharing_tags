Dir.chdir(File.expand_path("../dummy", __FILE__)) { require File.expand_path("config/environment") }

require 'rspec/rails'
require 'pry'
require 'rspec-html-matchers'
require 'ammeter/init'
require 'slim'
require 'rspec/support/spec'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.configuration.git_dir = "."
  CodeClimate::TestReporter.start
end

require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.include RSpecHtmlMatchers
  config.include GeneratorSupport, type: :generator

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

end