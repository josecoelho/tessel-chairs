class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: session_params[:name])

    if @user
      session[:current_user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "Invalid credentials"
      redirect_to new_session_path
    end
  end

  private

    def session_params
      params.require(:user).permit(:name)
    end

end
