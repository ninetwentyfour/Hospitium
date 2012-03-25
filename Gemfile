source 'http://rubygems.org'

gem 'rails', '3.2.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'devise' # Devise must be required before RailsAdmin
gem 'nokogiri'
gem 'mechanize'
gem 'uuidtools'
gem 'cancan'
gem "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"
gem 'aws-sdk', '~> 1.3.4'
gem 'will_paginate'
gem 'paper_trail'
gem 'oauth'
gem 'twitter'
gem 'rest-client'
gem 'json'
gem 'libxml-xmlrpc'
gem 'bitly'
gem 'site_meta'
gem 'meta_search'
gem 'airbrake'
gem 'spork', '~> 1.0rc'
gem 'client_side_validations'
gem 'jqplot-rails', :git => "git://github.com/ninetwentyfour/jqplot-rails.git"
gem 'asset_sync'
gem 'gravatar_image_tag'
gem 'best_in_place'
gem 'juggernaut'
gem 'jquery-rails'
gem 'less-rails-bootstrap'
gem "spreadsheet", "0.6.5.8"
gem "to_xls", :git => "https://github.com/dblock/to_xls.git", :branch => "to-xls-on-models"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'closure-compiler'
end

group :development do
	gem 'metrical'
end

group :production do
	gem 'home_run', :require=>'date'
	#gem 'slim_scrooge', :git => "git://github.com/sdsykes/slim_scrooge.git"
	gem 'dalli'
	gem 'thin'
	gem 'pg'
	gem 'newrelic_rpm'
	gem 'heroku'
end

gem "rspec-rails", :group => [:test, :development]
group :test do
	gem "factory_girl_rails"
	gem "capybara"
	gem 'capybara-webkit'
	gem 'shoulda-matchers'
	gem 'cucumber-rails', require: false
	gem 'database_cleaner'
	gem 'launchy'
	gem 'email_spec'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'