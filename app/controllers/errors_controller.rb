class ErrorsController < ApplicationController
  # 401 - missing or invalid auth token
  def unauthorized
    render json: { error: "Unauthorized", message: "Missing or invalid authentication token" },
           status: :unauthorized
  end

  # 403 - authenticated but not allowed
  def forbidden
    render json: { error: "Forbidden", message: "You do not have permission to access this resource" },
           status: :forbidden
  end

  # 422 - raises an ArgumentError deep in the call stack (produces a real stack trace)
  def bad_request
    parse_request_payload
  end

  # 503 - simulates a downstream dependency blowing up with a real stack trace
  def service_unavailable
    simulate_database_call
  end

  private

  def parse_request_payload
    validate_schema
  end

  def validate_schema
    coerce_types
  end

  def coerce_types
    raise ArgumentError, "Invalid value for field 'amount': expected Integer, got \"abc\""
  end

  def simulate_database_call
    fetch_from_cache
  end

  def fetch_from_cache
    connect_to_primary
  end

  def connect_to_primary
    raise RuntimeError, "Connection to primary database timed out after 30000ms"
  end
end
