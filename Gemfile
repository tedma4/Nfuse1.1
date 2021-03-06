source 'https://rubygems.org'

#This is the rails version we are using
gem 'rails', '4.2.5'
gem 'elastic-beanstalk', '~> 1.1.3'
gem 'rack', '~>1.6.0'
gem 'sqlite3'
#This allows us to use bootstrap css file
gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass-rails', '>= 3.2'
gem 'sprockets', '~> 2.8'
#This is used to encrypt a user's password
gem 'bcrypt', '~> 3.1.7'
gem 'ancestry'
gem 'responders', '~> 2.0'
#This adds pagination to pages that need it
# gem 'will_paginate', '~> 3.0.4'
# gem 'bootstrap-will_paginate', '~> 0.0.9'
#This allows us to send an email
gem 'mail_form'
#This allows us to simplify the form making process
gem 'simple_form'
#This allows the us to upload images, videos and files
gem 'paperclip', "4.3.5"
gem "nokogiri", ">= 1.6.7.rc"
#gem 'panda'
# Handles video upload
gem 'paperclip-av-transcoder', "0.6.4"
gem 'acts_as_votable', '~> 0.10.0'
# gem 'activeadmin', github: 'activeadmin'
gem 'wicked'
#This resizes a file uploaded by paperclip
gem 'rmagick', '2.13.2', :platforms => :ruby
# gem 'typhoeus', '~> 0.6.8'
gem 'httparty'
gem 'cocaine', '0.5.5'
#This allows the use of the facebook oauth
# gem 'omniauth', '1.1.1'
gem 'omniauth-facebook'
#This allows the use of the twitter oauth
gem 'omniauth-twitter'
gem 'omniauth-pinterest', '~> 2.0.1'
gem 'omniauth-vimeo'
gem 'omniauth-tumblr'
#This allows the use of the facebook graph api
gem 'fb_graph'
gem 'vimeo'
#gem 'instagram', '1.1.5'
gem 'vmo', :git => 'https://github.com/ermacaz/vmo.git'
gem 'tumblr_client'
#This allows the use of the twitter api
gem 'twitter', '>= 5.14.0'
gem 'koala', "~> 2.0"
gem 'yt', :git => 'https://github.com/ermacaz/yt.git'
gem 'excon', '~> 0.42.1'
#This allows the use of the instagram oauth
gem 'omniauth-instagram'
gem 'omniauth-google-oauth2'
gem 'omniauth-gplus'
gem 'google_plus'
gem 'faraday', '~> 0.9.0'
gem 'oj', '~> 2.9.3'
# gem 'oj_mimic_json', '~> 1.0.0'
gem 'newrelic_rpm'
# #This allows us to use burbon css file
# gem 'bourbon', '~> 3.2.3'
# gem 'neat', '~> 1.5.1'
gem 'seed-fu', '~> 2.3'

#This allows the use of the faye websocket server
# gem 'private_pub'
# gem 'thin'
gem 'auto_html'
gem 'faker', "~> 1.4.3"
gem 'public_activity', '1.4.2'
# gem 'eventmachine', :github => 'eventmachine/eventmachine', :branch => 'master'
# gem 'puma', '2.15.3'
gem 'faye-rails', '2.0'
gem 'thin', '~> 1.6.4', group: :development
gem 'remotipart', '1.2.1'
# gem 'kaminari', '0.16.3'
group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # v-- Used in both dev and testing.
  gem 'rspec-rails', '~> 3.1.0'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'rails-erd'
  gem 'simplecov'
  # gem 'byebug', '8.2.2'

  # ^-- Used in both dev and testing.
end
#These are the gems used in the test enviornment
group :test do

  gem 'brakeman', :require => false
  # gem 'rb-notifu', '0.0.4'
  # gem 'win32console', '1.3.2'
  # gem 'wdm', '0.1.0'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers', '~> 2.6.0', require: false
  gem 'capybara', '~> 2.4.3'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'launchy', '~> 2.4.2'
  gem 'selenium-webdriver', '~> 2.43.0'
  gem 'pry'
  gem 'pry-rails'
end
# Use SCSS for stylesheets
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
gem 'coffee-script-source', '1.8.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
#This allows the use of embedded javascript
gem 'ejs', '~> 1.1.1'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'impressionist', '1.5.1'
# gem 'videojs_rails'

gem 'aws-sdk', '< 2'
gem 'figaro'
group :doc do
  gem 'sdoc', '~> 0.4.0', require: false
end
#These are the gems used in the production enviornment
group :production do
  gem 'mysql2'
  gem 'thin', '~> 1.6.4'
  # gem 'rails_12factor', '~> 0.0.3'
end
#These are the gems used in the development enviornment
group :development do
  gem 'bullet', "4.14.7"
  # gem 'rack-mini-profiler', require: false
  # gem 'flamegraph'
  # gem 'stackprof' # ruby 2.1+ only
  # gem 'memory_profiler'
  end

gem 'tzinfo-data', platforms: [:mingw, :mswin]
