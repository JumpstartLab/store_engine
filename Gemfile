source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'jquery-rails'
gem 'growl'
gem 'guard-rspec'
gem 'launchy'
gem 'stripe'
gem 'sorcery'
gem 'carrierwave'
gem 'twitter-bootstrap-rails'
gem 'simple_form'
gem 'bcrypt-ruby'
gem 'nifty-generators', :group => :development

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
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'faker'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'thin'
end

group :test do
  gem 'guard-spork'
  gem 'spork'
  gem 'simplecov', :require => false
end

gem "mocha", :group => :test
