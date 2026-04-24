Tracelit.configure do |config|
  config.api_key      = "b8c4bc37c7362b9ccc31d3f6ff49fc9c1c7beaaf12cae6d84d3a1278003e3573"
  config.service_name = "tracelit-test-rails"
  config.environment  = "development"
  config.sample_rate  = 1.0
  config.enabled      = true
  config.endpoint     = "http://localhost:4318"
end
