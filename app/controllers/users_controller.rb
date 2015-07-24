class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      # # This line overrides the default rendering behavior, which
      # # would have been to render the "create" view.
      render "new"
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to root_url
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :date_of_birth, :nhi, :complaint_id, :triage_id, :location_id, :discharge_status_id)
    end

end
