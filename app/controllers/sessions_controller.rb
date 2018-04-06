class SessionsController < ApplicationController
  before_action :find_by_email, only: [:create]
  
  def new
  end

  def create
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
    params.require(:user).permit :email, :password
  end

  def find_by_email
    @user = User.find_by email: sign_in_params[:email]
    if user.nil?
      flash[:danger] = t "users.show.error"
      redirect_to root_url
    end
  end
end
