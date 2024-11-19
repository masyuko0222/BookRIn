# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'vcr'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end

  VCR.configure do |config|
    config.ignore_hosts '127.0.0.1', 'localhost'
    config.cassette_library_dir = 'fixtures/vcr_cassettes'
    config.hook_into :webmock

    config.filter_sensitive_data('<FBC_LOGIN_NAME>') { ENV['FBC_LOGIN_NAME'] }
    config.filter_sensitive_data('<FBC_PASSWORD>') { ENV['FBC_PASSWORD'] }
  end
end
