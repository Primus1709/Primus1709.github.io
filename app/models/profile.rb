# Your name, bio, links and skills live in config/profile.yml.
# This class reads that file so views can call `profile[:name]` and so on.
class Profile
  PATH = Rails.root.join("config/profile.yml")

  def self.current
    # Re-read on every request in development so edits show up right away
    return load_file unless Rails.env.production?

    @current ||= load_file
  end

  def self.load_file
    YAML.load_file(PATH).deep_symbolize_keys
  end
end
