require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Portfolio
  class Application < Rails::Application
    config.load_defaults 8.0

    # Don't generate system tests or helpers when using `bin/rails generate`
    config.generators do |g|
      g.system_tests nil
      g.helper false
    end
  end
end
