class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include SessionsHelper

  protect_from_forgery with: :exception

  def index
    if logged_in?
      render_application
    else
      render_login
    end
  end

  private

  def render_application
    @page_js = @page_css = 'application'
  end

  def render_login
    @page_js = @page_css = 'logout_view'
  end

end
