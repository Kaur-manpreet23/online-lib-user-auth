class UsersController < ApplicationController
  before_action :authenticate_user!
  def dashboard
        @user = User.find_by(id: @current_user_id)
        render json: { user: @user, role: @user.role }
  end


  def get_history
      @user = User.find_by(id: @current_user_id)
      @history = @user.history
      render json: {history: @history}
  end

  def delete_user
        user = User.find_by(id: @current_user_id)
        resp = user.del_user(params[:email],params[:password])
        render json: {message: resp}
  end

  def add_user
      user = User.find_by(id: @current_user_id)
      resp = user.adding_user(params[:email],params[:password],params[:password_confirmation],params[:role])
      render json: {message: resp}
  end
end
