#source 'http://ruby.taobao.org'

gem 'rails'

gem 'capistrano', '2.5.19'
gem 'open4',      '0.9.3'
gem 'syntax',     '1.0.0'
gem 'version_fu'
gem 'devise'
gem 'compass'
gem 'haml'

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
gem 'mysql2', '< 0.3'
gem 'rvm-capistrano'

gem 'whenever', :require => false

gem 'sprockets'
gem 'hike'
gem "kiqstand"

gem 'sidekiq', :git => 'git://github.com/mperham/sidekiq.git', :require => 'sidekiq/capistrano'
gem 'slim', :git => 'git://github.com/slim-template/slim.git'
