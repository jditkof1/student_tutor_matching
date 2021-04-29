class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :keep_out_unless_logged_in
  
  protected

  # accessor
  def current_user
    # Avoid unnecessary database queries
    @current_user ||= User.find(session[:user_id])
  end

  # mutator:  gets set in sessions controller
  def current_user=(user)
    @current_user = user
  end
  
  def keep_out_unless_logged_in
    redirect to welcome_landing_path unless (!!current_user)
  end 
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
