class FollowsController < ApplicationController
  before_action :check_logged_in

  def show
    @user = current_user
    if params[:check_follow_id] == "1"
      @title = t "shared.stats.following"
      @users = user.following.paginate page: params[:page]
      render "users/show_follow"
    else
      @title = t "shared.stats.followers"
      @users = user.followers.paginate page: params[:page]
      render "users/show_follow"
    end
  end

  private

  attr_reader :user
end
