class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :sign_in]

  def index
  end

  def sign_in
    @user = User.authenticate!(params[:login_id])
    session[:token] = @user.token
    redirect_to blocklies_path
  rescue
    redirect_to root_path
  end

  def sign_out
    User.extinguish!
    reset_session
    redirect_to root_path
  end
end
