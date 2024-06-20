class TokenValidationController < ApplicationController
  before_action :authenticate_user!
  def validate_token
    render json: {isValid: true,userid: @current_user_id}, status: :ok
  end

end
