class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def default_url_options options = {}
    {locale: I18n.locale}.merge options
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to root_path
  end
end
