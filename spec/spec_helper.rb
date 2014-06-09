ENV["RAILS_ENV"] ||= 'test'
require 'coveralls'
Coveralls.wear!('rails')

require 'spork'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.default_cassette_options = { record: :new_episodes }
  c.configure_rspec_metadata!
end

Spork.prefork do
  unless ENV['DRB']
    SimpleCov.start 'rails'
  end

  require 'capybara/rspec'
  require 'capybara-screenshot/rspec'
  require 'database_cleaner'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'webmock/rspec'
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  Capybara.javascript_driver = :webkit
  Capybara.asset_host = 'http://localhost:3000'
  WebMock.disable_net_connect!(allow_localhost: true)

  RSpec.configure do |config|
    #config.extend VCR::RSpec::Macros
    config.include Capybara::DSL
    config.include FactoryGirl::Syntax::Methods

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
    
    # from: http://engineering.sharethrough.com/blog/2013/08/10/greater-test-control-with-rspecs-tag-filters/
    config.treat_symbols_as_metadata_keys_with_true_values = true
  end
end

Spork.each_run do
  if ENV['DRB']
    SimpleCov.start 'rails'
  end
end