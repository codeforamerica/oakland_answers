# encoding: UTF-8
require 'spork'

Spork.prefork do

  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end


  def logger
    Rails.logger
  end

  def saop
    save_and_open_page
  end

  require 'database_cleaner'
  require 'rubygems'
  require 'capybara/rspec'
  Capybara.javascript_driver = :webkit

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  require 'webmock/rspec'
  WebMock.disable_net_connect!(allow_localhost: true)

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.infer_base_class_for_anonymous_controllers = false
    config.include Capybara::DSL

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
    require 'simplecov'
    SimpleCov.start 'rails'
  end
end