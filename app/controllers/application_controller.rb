class ApplicationController < ActionController::Base
  before_action :set_referer
  helper_method :current_user

  private

  def set_referer
    session[:return_to] = request.referer if request.url != request.referer
  end

  def current_user
    @current_user ||= User.first
  end
end
