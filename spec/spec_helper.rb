ENV["RAILS_ENV"] ||= 'test'
require 'coveralls'
Coveralls.wear!('rails')

require 'spork'

Spork.prefork do
  unless ENV['DRB']
    SimpleCov.start 'rails'
  end

  require 'capybara/rspec'
  require 'database_cleaner'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'webmock/rspec'
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  Capybara.javascript_driver = :webkit
  Capybara.asset_host = 'http://localhost:3000'
  WebMock.disable_net_connect!(allow_localhost: true)

  RSpec.configure do |config|
    config.include Capybara::DSL
    config.include FactoryGirl::Syntax::Methods
    config.infer_spec_type_from_file_location!

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
  end
end

Spork.each_run do
  if ENV['DRB']
    SimpleCov.start 'rails'
  end
end
