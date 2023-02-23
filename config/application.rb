require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Shikaku
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpersand assets when generating a new resource.
    config.api_only = true

    #　以下の記述を追記する(設定必須)
    # デフォルトのlocaleを日本語(:ja)にする
    config.i18n.default_locale = :ja
    # I18nライブラリに訳文の探索場所を指示する
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]

    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
    config.middleware.use ActionDispatch::Flash
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:8000',
                'http://localhost:3000',
                'https://shikaku.dev/'

        resource '*',
                 headers: :any,
                 expose: %w[access-token uid client],
                 methods: %i[get post put patch delete options head],
                 credentials: true
      end
    end
  end
end
