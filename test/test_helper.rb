ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)

    # Loads every file in test/fixtures before each test
    fixtures :all
  end
end

module AdminTestHelpers
  def admin_headers
    { "Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials("admin", "password") }
  end
end
