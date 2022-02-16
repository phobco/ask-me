source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'puma', '~> 5.0'

gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'

gem 'rails-i18n', '~> 6.0.0'

gem 'uglifier'
gem 'rails_12factor'
gem "validate_url"
gem "recaptcha"

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'byebug'
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
end
