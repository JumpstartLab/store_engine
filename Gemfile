source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'jquery-rails'
#gem 'sqlite3'
gem 'bootstrap-sass', '2.0.0'
gem 'bcrypt-ruby', '3.0.1'
gem 'sorcery'
gem 'money-rails'
gem 'stripe'
gem 'faker'
gem 'rake'

group :production do
  gem 'pg'
end

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
  # gem 'fabrication'
  gem 'sqlite3'
  gem 'reek', :git => "git://github.com/mvz/reek.git", :branch => "ripper_ruby_parser-2"
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl_rails', '~> 3.1.0'
  gem 'guard'
  gem 'growl'
  #gem 'cane'
  gem 'reek', :git => "git://github.com/mvz/reek.git", :branch => "ripper_ruby_parser-2"
  gem 'simplecov'
  #gem 'ruby-debug19', :require => 'ruby_debug'
end
