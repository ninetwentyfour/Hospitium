source 'http://rubygems.org'
ruby "2.3.1"

# load ENV vars for testing and dev
gem 'dotenv-rails', :groups => [:development, :test]

gem 'rails', '4.2.6'

# Gems used in all environments
# gem 'mysql2'
gem 'pg'
gem 'dalli'
gem 'aws-sdk'
gem 'devise', '3.5.9'
gem 'uuidtools'
gem 'cancan'
gem "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'ransack', github: 'activerecord-hackery/ransack', branch: 'rails-4.2'
gem 'juggernaut'
gem 'gravatar_image_tag'
gem "spreadsheet"
gem "comma"
gem 'redcarpet'
gem 'encryptor'
# gem 'json_builder'
gem 'jbuilder'
gem "statsd-ruby", :require => "statsd"
gem 'impressionist',:github => "Loremaster/impressionist" # record views of public animals
gem 'bitly'
gem 'octokit'
gem 'chronic'
gem 'public_activity'
gem 'vpim'
gem 'sendgrid-ruby'
# generate color schemes
gem 'paleta'
# security
gem 'secure_headers'
gem 'rack-attack'
gem 'rack-timeout'

# hack for rails 4.1
gem "polyamorous", :github => "activerecord-hackery/polyamorous"
# UUID MIGRATION
gem 'webdack-uuid_migration', :github => "ninetwentyfour/webdack-uuid_migration"

# faster json
gem 'oj'
gem 'oj_mimic_json'

# heroku gems for pulling/pushing db
# gem 'heroku'
# gem 'sqlite3'
# gem 'taps'


# add these gems to help with the transition to rails4:
gem 'protected_attributes'
gem 'rails-observers'

# Gems used only for production
group :production do
	gem 'airbrake'
	gem 'newrelic_rpm'
	gem 'heroku'
	gem 'rails_12factor'
end

# Gems used for production and development
# group :production, :development do
	gem 'nokogiri'
	gem 'mechanize'
	gem 'oauth'
	gem 'twitter'
	gem 'rest-client'
	gem 'json'
	gem 'libxml-xmlrpc'
	gem 'rqrcode-rails3'
	gem 'asset_sync'
	gem 'sanitize'
	gem 'puma', '~> 3.4.0'
	gem 'client_side_validations', :git => "git://github.com/substantial/client_side_validations.git", :branch => "support-rails-4.1"
	gem 'best_in_place', github: "ninetwentyfour/best_in_place"
	gem 'therubyracer'
	gem 'jquery-rails', '4.1.1'
	gem 'select2-rails'
	gem 'site_meta'

	# Gems used only for assets and not required
	# in production environments by default.
	# gem 'sass-rails'
	gem 'less-rails'
	gem 'coffee-rails'
	gem 'uglifier'
	gem 'yui-compressor'
	gem 'closure-compiler', '1.1.10'
# end

group :test, :development do
  gem "rspec-rails"
  gem "rspec"
  # gem "brakeman"
end

# Gems used only for testing
group :test do
	gem "factory_girl_rails"
	gem "capybara"
	# gem "capybara-webkit"
	gem 'selenium-webdriver'
	gem 'shoulda-matchers'
	# gem 'cucumber-rails', :require => false
	gem 'database_cleaner'
	# gem 'launchy'
	gem 'email_spec'
	gem 'poltergeist', '~> 1.9.0'
	gem 'capybara-email'
	# gem 'mocha', "~> 0.13.2", :require => false
	gem 'webmock'
	gem 'vcr'
	gem 'simplecov', :require => false
	gem 'coveralls', :require => false
end
