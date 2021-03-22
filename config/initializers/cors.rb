# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors, https://blog.jverkamp.com/2020/01/16/rackcors-configuration-tricks/

# These are the Rack::Cors settings that we want to set, first for all domains and then for trusted ones
default_cors_headers = {
  headers: :any,
  credentials: false,
  methods: %i[get post options head]
}

cors_headers_internal = default_cors_headers.merge(
  credentials: true,
  expose: %i[access-token expiry token-type uid client],
  methods: %i[get post put patch delete options head]
)

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins [Rails.application.credentials[Rails.env.to_sym].dig(:app_url)]
    resource '*', cors_headers_internal
  end

  # allow do
  #   origins '*'
  #   resource '*', default_cors_headers
  # end
end
