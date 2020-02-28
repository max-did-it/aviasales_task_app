source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'mysql2', '>= 0.4.4'
gem 'puma', '~> 4.1'
gem 'blueprinter'

group :development, :test do
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  gem 'rspec'
  gem 'rspec-mocks'
  gem 'rspec-rails'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
