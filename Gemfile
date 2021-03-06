source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.beta3', '< 5.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
gem 'sprockets', '>=3.0.0.beta'
gem 'sprockets-es6'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5.x'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'active_model_serializers', '>= 0.10.0.rc3'

gem 'acts_as_list', github: 'fauxparse/acts_as_list'

gem 'haml'
gem 'bourbon'
gem 'neat'
gem 'font-awesome-sass'

gem 'oauth2', github: 'intridea/oauth2'
gem 'omniauth-oauth2', '~> 1.4.0'
gem 'omniauth-google-oauth2', '~> 0.4.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry-rails'
  gem 'rspec', '3.5.0.beta3'
  gem 'rspec-rails', '3.5.0.beta3'
  gem 'rspec-collection_matchers', github: 'rspec/rspec-collection_matchers'
  gem 'rails-controller-testing', :git => 'https://github.com/rails/rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'timecop'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'rubocop'
  gem 'poltergeist'
end

gem 'dotenv-rails'
gem 'codeclimate-test-reporter', group: :test, require: nil

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-cucumber'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
  gem 'guard-rspec', '~> 4.6.5', require: false
  gem 'guard-cucumber'
  gem 'guard-ctags-bundler'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
