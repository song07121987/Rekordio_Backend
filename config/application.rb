require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rekordio
  class Application < Rails::Application
    CONSTS = {
      app_name:         "Rekordio",
      app_host:         "http://rekordio-prototype.herokuapp.com",
      app_token:        "a12345678",
      contact_email:    "rekordio@admin.com",
      contact_phone:    "+12345678",
      log_out:          "rekordio_log_out",
      cookie_name:       "_rekordio",
      expire_time:      30.minutes,

      dev_host:         "http://192.168.0.209:4035",
      dev_ip:           "192.168.0.209",
      dev_port:         "4035"
    }
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

    # For RESTful API by Grape
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
  end
end
