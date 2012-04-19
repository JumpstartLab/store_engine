source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'jquery-rails'
gem 'bcrypt-ruby', '3.0.1'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.5'
gem 'heroku'
gem 'twitter-bootstrap-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'sqlite3'
  gem 'fabrication'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'guard'
  gem 'guard-rspec'
  gem 'growl'
  gem 'simplecov'
  gem 'faker'
  gem 'factory_girl_rails', '1.4.0'
end

group :production do
  gem 'pg'
  gem 'thin'
end