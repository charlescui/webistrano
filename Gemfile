source 'https://rubygems.org'
# source 'http://ruby.taobao.org'

gem 'capistrano', :require => 'capistrano'
gem 'sidekiq', :git => 'git://github.com/mperham/sidekiq.git'
gem 'slim', :git => 'git://github.com/slim-template/slim.git'

gem 'rails'

gem 'open4'
gem 'syntax'
gem 'version_fu'
gem 'devise'
gem 'sass'
gem 'haml', :require => 'sass'

group :assets do
  gem 'compass-rails', require: 'compass'
  gem 'sass-rails', require: 'compass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
end

group :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'test-unit', '2.0.9', :require => 'test/unit'
  gem 'mocha'
  gem 'factory_girl_rails'
end

group :production do
  gem 'unicorn'
end
gem 'mysql2'
gem 'rvm-capistrano'

gem 'whenever', :require => false

gem 'sprockets'
gem 'hike'
