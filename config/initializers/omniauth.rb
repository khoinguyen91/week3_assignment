OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '252914668383017', 'b752e8bec641692158450f68318a32c'
end