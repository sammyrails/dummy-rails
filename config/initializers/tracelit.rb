Tracelit.configure do |config|
  config.api_key      = ENV["TRACELIT_API_KEY"]
  config.service_name = "Rails"
  config.environment  = ENV.fetch("RAILS_ENV", "production")
end
