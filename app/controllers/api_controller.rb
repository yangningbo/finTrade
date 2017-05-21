class ApiController < ActionController::API
  include ActionController::RespondWith
  include ActionController::StrongParameters
  include SessionsHelper
  respond_to :json

  before_action :set_request_cookies
  around_action :catch_exceptions

  def set_request_cookies
    $request_cookies = request.env['HTTP_COOKIE']
  end

  private

  def catch_exceptions
    begin
      yield
    rescue Exception => error
      Rails::logger.warn(error.message)
      render json: {:message => error.message}.to_json, status: :internal_server_error
    end
  end
end