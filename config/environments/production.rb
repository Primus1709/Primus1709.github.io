require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false

  # Fingerprinted assets can be cached forever
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Most hosts terminate SSL for you. Set FORCE_SSL=false if yours doesn't.
  config.assume_ssl = ENV.fetch("FORCE_SSL", "true") == "true"
  config.force_ssl = ENV.fetch("FORCE_SSL", "true") == "true"
  config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  config.log_tags = [ :request_id ]
  config.logger = ActiveSupport::TaggedLogging.logger($stdout)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/up"

  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
  config.i18n.fallbacks = true
end
