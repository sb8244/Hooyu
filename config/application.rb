require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require 'neo4j/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hooyu
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.assets.enabled = false

    if ENV['NEO4J_USER'] && ENV['NEO4J_PASSWORD']
      config.neo4j.session_options = { basic_auth: { username: ENV['NEO4J_USER'], password: ENV['NEO4J_PASSWORD']} }
    end

    config.neo4j.session_type = :server_db
    config.neo4j.session_path = ENV['NEO4J_URL']

    config.paperclip_defaults = {
        storage: :s3,
        url: ':s3_domain_url',
        path: ':class/:attachment/:hash/:style.:extension',
        hash_secret: ENV["HASH_SECRET"],
        s3_credentials: {
            bucket: ENV['S3_BUCKET_NAME'],
            access_key_id: ENV['AWS_ACCESS_KEY_ID'],
            secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
        }
    }
  end
end
