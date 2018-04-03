class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: sign_in_params[:email]
    if user && user.authenticate(sign_in_params[:password])
      log_in user
      redirect_to user
    else
      flash[:danger] = t ".error"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  attr_accessor :user

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
