class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  private

    def require_login
      unless session[:current_user_id]
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_session_url
      end

      @current_user = current_user
    end

    def current_user
      User.find_by(id: session[:current_user_id])
    end

end
