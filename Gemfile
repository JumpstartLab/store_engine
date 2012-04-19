source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'jquery-rails'

gem 'sorcery'

#gem 'rmagick'
gem 'mini_magick'
gem 'carrierwave'
gem 'twitter-bootstrap-rails'
gem 'stripe'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'pg'
end

group :development, :test do
  # gem 'capybara-webkit'
  # gem 'prickle'
  gem 'growl'
  gem 'sqlite3'
  gem 'fabrication'
  gem 'faker'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'guard-rspec'
  gem 'database_cleaner'
  gem 'simplecov'#, :group => :test
  gem 'reek', :git => "git://github.com/mvz/reek.git", :branch => "ripper_ruby_parser-2"
  gem 'cane', :git => "git://github.com/square/cane.git"
end
