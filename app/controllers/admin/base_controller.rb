module Admin
  # Every admin controller inherits from this one, so they're all behind the password.
  class BaseController < ApplicationController
    layout "admin"

    before_action :require_admin
    before_action :count_unread_messages

    private

    def require_admin
      password = ENV["ADMIN_PASSWORD"].presence
      password ||= "password" unless Rails.env.production?

      if password.nil?
        render plain: "Admin is turned off. Set the ADMIN_PASSWORD environment variable to turn it on.",
               status: :service_unavailable
        return
      end

      username = ENV.fetch("ADMIN_USERNAME", "admin")

      authenticate_or_request_with_http_basic("Portfolio admin") do |given_username, given_password|
        # secure_compare takes the same time whether the guess is close or not
        ActiveSupport::SecurityUtils.secure_compare(given_username, username) &
          ActiveSupport::SecurityUtils.secure_compare(given_password, password)
      end
    end

    def count_unread_messages
      @unread_count = Message.unread.count
    end
  end
end
