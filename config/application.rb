require_relative 'boot'

require File.expand_path('../boot', __FILE__)
ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Test18
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    
    # setup i18n default zh-TW
    config.i18n.default_locale = "zh-TW"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    #setup timezone = taipei
    config.time_zone = "Taipei"

    config.exceptions_app = self.routes
  end
end
