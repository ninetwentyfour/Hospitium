source 'http://bundler-api.herokuapp.com'
ruby "1.9.3"

gem 'rails', '3.2.13'

# Gems used in all environments
gem 'mysql2'
gem 'dalli'
gem 'aws-sdk'
gem 'devise' # Devise must be required before RailsAdmin
gem 'uuidtools'
gem 'cancan'
gem "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"
gem 'will_paginate'
gem 'site_meta'
gem 'ransack'
gem 'juggernaut'
gem 'client_side_validations'
# gem 'jqplot-rails', :git => "git://github.com/ninetwentyfour/jqplot-rails.git"
gem 'gravatar_image_tag'
gem 'best_in_place'
gem "spreadsheet"
gem "to_xls", :git => "https://github.com/dblock/to_xls.git", :branch => "to-xls-on-models"
gem 'redcarpet'
gem 'jquery-rails', '2.0.1'
gem 'select2-rails', :git => "git://github.com/ninetwentyfour/select2-rails.git"
gem 'less-rails-bootstrap', '2.2.0'
gem 'therubyracer'
gem 'encryptor'
gem 'json_builder'

gem "statsd-ruby", :require => "statsd"
gem 'impressionist'
gem 'unicorn'

# generate color schemes
gem 'paleta'

# heroku gems for pulling/pushing db
# gem 'heroku'
# gem 'sqlite3'
# gem 'taps'

gem 'bitly'
gem 'octokit'

# security
gem 'secure_headers'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'yui-compressor'
  gem 'closure-compiler'
end

# Gems used only for production
group :production do
	gem 'airbrake'
	gem 'home_run', :require=>'date'
	gem 'pg'
	gem 'newrelic_rpm'
	gem 'heroku'
end

# Gems used for production and development
group :production, :development do
	gem 'nokogiri'
	gem 'mechanize'
	gem 'oauth'
	gem 'twitter'
	gem 'rest-client'
	gem 'json'
	gem 'libxml-xmlrpc'
	# gem 'bitly'
	gem 'rqrcode-rails3'
	gem 'asset_sync'
	gem 'sanitize'
	# gem 'octokit'
end

group :test, :development do
  gem "rspec-rails"
  gem "rspec"
  # gem "brakeman"
end
# Gems used only for testing
group :test do
	gem "factory_girl_rails"
	gem "capybara"
	gem 'shoulda-matchers'
	gem 'cucumber-rails', :require => false
	gem 'database_cleaner'
	gem 'launchy'
	gem 'email_spec'
	gem 'poltergeist', "~> 1.1.0"
	gem 'mocha', "~> 0.13.2", :require => false
	gem 'fakeweb'
	gem 'vcr'
	gem 'simplecov', :require => false
	gem 'coveralls', :require => false
end