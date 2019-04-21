class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :sign_in]

  def index
  end

  def sign_in
    @user = User.authenticate!(params[:login_id])
    session[:token] = @user.token
    redirect_to blocklies_path
  end

  def sign_out
    session[:token] = nil
    redirect_to root_path
  end
end
