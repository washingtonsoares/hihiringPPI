require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'devise'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Code
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

    config.to_prepare do
      Admin::Users::SessionsController.layout "admin/application"
      Admin::Users::RegistrationsController.layout proc{ |controller| user_signed_in? ? "admin/application" : "admin/application" }
      Admin::Users::ConfirmationsController.layout proc{ |controller| user_signed_in? ? "admin/application" : "admin/application" }
      Admin::Users::UnlocksController.layout "admin/application"
      Admin::Users::PasswordsController.layout "admin/application"
      Admin::Users::InvitationsController.layout "admin/application"
    end

  end
end
