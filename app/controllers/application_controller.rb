class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :process_token
  after_action :log_action

  def process_token
    if request.headers['Authorization'].present?
      begin
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.secrets.secret_key_base).first
        @current_user_id = jwt_payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end
    end
  end

  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end

  def signed_in?
    @current_user_id.present?
  end

  def log_action
    user_id = @current_user_id || nil

    message = "User #{user_id} performed #{params[:action]} on #{params[:controller]}"

    Log.create(action: message,user_id: user_id,timestamp: Time.now)
  end

end
