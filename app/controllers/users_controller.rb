class UsersController < ApplicationController
  before_action :check_logged_in, except: [:new, :show, :create]
  before_action :find_user, except: [:new, :index, :create]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page]
    @post = Post.new
  end

  def show
    @posts = @user.posts.by_default.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user 
      flash[:success] = t ".success"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".destroy"
      redirect_to users_url
    end
    authorize! :destroy, @user
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, 
      :password_confirmation
  end

  def correct_user
    redirect_to root_url unless current_user.correct_user? @user
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "users.show.error"
      redirect_to root_url
    end
  end
end
