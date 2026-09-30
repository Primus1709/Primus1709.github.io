source "https://rubygems.org"

ruby ">= 3.2.0"

gem "rails", "~> 8.0"

# Serves the CSS, JS and images in app/assets
gem "propshaft"

# Database: a single file in storage/, no server to install
gem "sqlite3", ">= 2.1"

# Web server
gem "puma", ">= 5.0"

# Faster boot times
gem "bootsnap", require: false

# Time zone data for Windows
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
end

group :test do
  gem "minitest", "~> 5.25"
end
