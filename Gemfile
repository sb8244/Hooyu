source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

gem 'puma'
gem 'foreman'

group :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'vcr'
  gem 'webmock'
end

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry'
end

# db
gem 'pg'
gem 'neo4j', '~> 4.1.1'

# env
gem 'dotenv-rails'
gem 'rails_12factor', group: :production

gem 'responders', '~> 2.0'

# Authentication
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'devise'

gem "neo4jrb-paperclip", github: 'subvertallchris/neo4jrb-paperclip', require: "neo4jrb_paperclip"
gem "aws-sdk"
