Tracelit.configure do |config|
  config.api_key      = ENV["TRACELIT_API_KEY"]
  config.service_name = ENV["TRACELIT_SERVICE_NAME"]
  config.environment  = ENV["TRACELIT_ENVIRONMENT"]
  config.sample_rate  = 1.0
  config.enabled      = !defined?(Rails::Console)
  config.endpoint     = ENV["TRACELIT_ENDPOINT"]
end
