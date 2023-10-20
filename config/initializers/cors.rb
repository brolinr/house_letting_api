Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch('ALLOWED_DOMAIN', '*')

    resource '/api/v2/*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end