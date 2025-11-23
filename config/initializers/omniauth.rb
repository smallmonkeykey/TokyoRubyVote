OmniAuth.config.request_validation_phase = OmniAuth::AuthenticityTokenProtection.new(key: :_csrf_token)

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, Rails.application.credentials.github[:client_id], Rails.application.credentials.github[:client_secret]
end
