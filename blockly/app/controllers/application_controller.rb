class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user_by_token!

  def current_user
    User.current
  end
  helper_method :current_user

  private
    def authenticate_user_by_token!
      if user = User.find_by(token: session[:token])
        User.current = user
      else
        redirect_to root_path
      end
    end
end
