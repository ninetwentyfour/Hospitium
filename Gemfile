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
#gem 'ckeditor'
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
	gem 'slim_scrooge'
	gem 'dalli'
end

gem "rspec-rails", :group => [:test, :development]
group :test do
	gem "factory_girl_rails"
	gem "capybara"
	gem 'shoulda-matchers'
	gem 'cucumber-rails'
	# database_cleaner is not required, but highly recommended
	gem 'database_cleaner'
	gem 'launchy'
	gem 'email_spec'
	gem 'headless'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'