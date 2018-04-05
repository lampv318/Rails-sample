class PostsController < ApplicationController
  before_action :check_logged_in, only: [:new, :create]

  def index
    @posts = Post.select(:id, :content, :user_id, :created_at).paginate(page: params[:page])
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new post_params
    if @post.save
      flash[:success] = t ".success"
      redirect_to user_path current_user
    else
      flash[:danger] = t "fail"
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit :content,
      images_attributes: [:link,  :_destroy]
  end
end
