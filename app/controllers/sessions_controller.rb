class SessionsController < ApplicationController
  include CurrentUserConcern
  before_action :authenticate_user!, only: [:destroy, :new]

  def create
    user = User
              .find_by(email: params["user"]["email"])
              .try(:authenticate, params["user"]["password"])
    if user
      token = generate_token(user.id)
      render json: {
        status: :created,
        logged_in: true,
        user: user,
        token: token
      }
    else
      render json: {status: 401}
    end
  end

  def destroy
    render json: {status: 200, logged_out: true}
  end

  def new
    if @current_user
      render json: {
        logged_in: true,
        user: @current_user
      }
    else
      render json: {
        logged_in: false
      }
    end
  end

  private
  def generate_token(id)
    JWT.encode({id: id, exp: 60.days.from_now.to_i}, Rails.application.secrets.secret_key_base)
  end

end
