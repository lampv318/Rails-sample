class PagesController < ApplicationController
  def home
    if logged_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.by_default.paginate page: params[:page]
    end
  end

  def show
    if valid_page?
      render template: "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
  end
end
