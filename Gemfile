source 'http://rubygems.org'

gem 'rails', '3.2.6'

# Gems used in all environments
gem 'mysql2'
gem 'dalli'
gem 'aws-sdk', '~> 1.3.4'
gem 'devise' # Devise must be required before RailsAdmin
gem 'uuidtools'
gem 'cancan'
gem "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"
gem 'will_paginate'
gem 'paper_trail'
gem 'site_meta'
gem 'meta_search'
gem 'juggernaut'
gem 'client_side_validations'
gem 'jqplot-rails', :git => "git://github.com/ninetwentyfour/jqplot-rails.git"
gem 'gravatar_image_tag'
gem 'best_in_place'
gem "spreadsheet", "0.6.5.8"
gem "to_xls", :git => "https://github.com/dblock/to_xls.git", :branch => "to-xls-on-models"
gem 'redcarpet'
gem 'jquery-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'closure-compiler'
end

# Gems used only for development
group :development do
	gem 'metrical'
end

# Gems used only for production
group :production do
	gem 'airbrake'
	gem 'home_run', :require=>'date'
	#gem 'slim_scrooge', :git => "git://github.com/sdsykes/slim_scrooge.git"
	gem 'thin'
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
	gem 'bitly'
	gem 'less-rails-bootstrap'
	gem 'rqrcode-rails3'
	gem 'asset_sync'
	gem 'sanitize'
	gem 'octokit'
	gem 'therubyracer'
end

gem "rspec-rails", :group => [:test, :development]
# Gems used only for testing
group :test do
	gem "factory_girl_rails"
	gem "capybara"
	gem 'capybara-webkit'
	gem 'shoulda-matchers'
	gem 'cucumber-rails', require: false
	gem 'database_cleaner'
	gem 'launchy'
	gem 'email_spec'
	# gem 'cover_me'
end