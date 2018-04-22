class PostsController < ApplicationController
  before_action :check_logged_in, only: [:new, :create]

  def index
    @posts = Post.select(:id, :content, :user_id, :created_at).paginate(page: params[:page])
    if params[:search]
      @search_users = User.search(params[:search]).order 'created_at DESC'
    else
      @search_users = User.all.order 'created_at DESC'
    end
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js
    end
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
      @feed_items = []
      flash[:danger] = t "fail"
      render :new
    end
  end

  private

  attr_reader :user

  def post_params
    params.require(:post).permit :content,
      images_attributes: [:link,  :_destroy]
  end
end
