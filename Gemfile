source 'http://rubygems.org'

#This is the rails version we are using
gem 'rails', '4.1.2'
gem 'elastic-beanstalk', '~> 1.1.3'
gem 'rack', '1.5.2'
gem 'sqlite3'
#This allows us to use bootstrap css file
gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass-rails', '>= 3.2'
gem 'sprockets', '~> 2.8'
#This is used to encrypt a user's password
gem 'bcrypt', '~> 3.1.7'
#This adds pagination to pages that need it
gem 'will_paginate', '~> 3.0.4'
gem 'bootstrap-will_paginate', '~> 0.0.9'
#This allows us to send an email
gem 'mail_form'
#This allows us to simplify the form making process
gem 'simple_form'
#This allows the us to upload images, videos and files
gem "paperclip", "4.2.0"
#gem 'panda'
# Handles video upload
gem 'paperclip-av-transcoder', "0.6.4"
gem 'acts_as_votable', '~> 0.10.0'
gem 'activeadmin', github: 'activeadmin'
gem 'wicked'
#This resizes a file uploaded by paperclip
gem 'rmagick', '~> 2.13.2', :platforms => :ruby
gem 'typhoeus', '~> 0.6.8'
gem "httparty"
gem 'cocaine', '0.5.3'
#This allows the use of the facebook oauth 
gem 'omniauth-facebook', '~> 1.6.0'
#This allows the use of the twitter oauth
gem 'omniauth-twitter', '~> 1.0.1'
#gem 'omniauth-pinterest', '~> 1.0.0'
gem 'omniauth-vimeo'
gem 'omniauth-pinterest'
gem 'omniauth-flickr'
#This allows the use of the facebook graph api
gem 'fb_graph'
gem 'vimeo'
gem 'flickraw'
#This allows the use of the twitter api
gem 'twitter', '~> 5.8.0'
gem 'yt', :git => 'https://github.com/ermacaz/yt.git'
gem 'excon', '~> 0.42.1'
#This allows the use of the instagram oauth 
gem 'omniauth-instagram', '~> 1.0.1'
gem 'omniauth-google-oauth2'
gem 'faraday', '~> 0.9.0'
gem 'oj', '~> 2.9.3'
gem 'oj_mimic_json', '~> 1.0.0'
gem 'newrelic_rpm', '~> 3.8.1.221'
# #This allows us to use burbon css file
# gem 'bourbon', '~> 3.2.3'
# gem 'neat', '~> 1.5.1'
gem 'seed-fu', '~> 2.3'

#This allows the use of the faye websocket server
gem 'private_pub'
gem 'thin'
gem 'auto_html'
gem "faker", "~> 1.4.3"

#These are the gems used in the development enviornment
# gem 'rack-mini-profiler', group: :development #causing errors each request
gem 'bullet', group: :development

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # v-- Used in both dev and testing.
  gem 'rspec-rails', '~> 3.1.0'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'rails-erd'
  gem 'simplecov'

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
  gem "capybara", "~> 2.4.3"
  gem "database_cleaner", "~> 1.3.0"
  gem "launchy", "~> 2.4.2"
  gem "selenium-webdriver", "~> 2.43.0"
  gem 'pry'
  gem 'pry-rails'
end
# Use SCSS for stylesheets
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
#This allows the use of embedded javascript
gem 'ejs', '~> 1.1.1'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'videojs_rails'

gem 'aws-sdk', '< 2'
gem 'figaro'
group :doc do
  gem 'sdoc', '~> 0.4.0', require: false
end
#These are the gems used in the production enviornment
group :production do
  gem 'mysql2'
  gem 'rails_12factor', '~> 0.0.3'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin]
