# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors, https://blog.jverkamp.com/2020/01/16/rackcors-configuration-tricks/

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins [Rails.application.credentials[Rails.env.to_sym].dig(:app_url)]
    resource '*', headers: :any, credentials: true, expose: %i[jwt], methods: %i[get post put patch delete options head]
  end
end
