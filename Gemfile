# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'bootsnap',                           '>= 1.4.4', require: false
gem 'image_processing',                   '~> 1.2'
gem 'paynow_sdk',                         '~> 1.1.0'
gem 'pg',                                 '~> 1.1'
gem 'puma',                               '~> 5.0'
gem 'rack-cors',                          '~> 2.0'
gem 'rails',                              '~> 6.1.4', '>= 6.1.4.4'

group :development, :test do
  gem 'byebug',                             '~> 11.1'
  gem 'debug',                              '~> 1.8'
  gem 'factory_bot_rails',                  '~> 6.2.0'
  gem 'ffaker',                             '~> 2.20.0'
  gem 'foreman',                            '~> 0.87.2'
  gem 'rubocop',                            '~> 1.35.0'
  gem 'rubocop-performance',                '~> 1.14.3'
  gem 'rubocop-rails',                      '~> 2.14.2'
  gem 'rubocop-rspec',                      '~> 2.8'
  gem 'shoulda-matchers',                   '~> 5.3'
end

group :development do
  gem 'web-console',                        '~> 4.2'
end

group :test do
  gem 'capybara',                           '~> 3.39.2'
  gem 'rspec-rails',                        '~> 6.0.1'
  gem 'selenium-webdriver',                 '~> 4.10.0'
  gem 'vcr',                                '~> 6.1.0'
  gem 'webdrivers',                         '~> 5.2.0'
end

gem 'listen', '~> 3.8'
