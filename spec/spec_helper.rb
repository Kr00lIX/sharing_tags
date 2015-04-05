Dir.chdir(File.expand_path("../dummy", __FILE__)) { require File.expand_path("config/environment") }

require 'rspec/rails'
require 'pry'
require 'rspec-html-matchers'
require 'slim'

CodeClimate::TestReporter.start

RSpec.configure do |config|
  config.include RSpecHtmlMatchers

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