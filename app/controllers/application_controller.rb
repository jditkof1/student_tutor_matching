class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :keep_out_unless_logged_in
  helper_method :current_user
  
  
  protected
  
  def keep_out_unless_logged_in
    redirect to welcome_landing_path unless (!!current_user)
  end
  
  # accessor
  def current_user
    # Avoid unnecessary database queries
    @current_user ||= User.find(session[:user_id])
  end

  # mutator:  gets set in sessions controller
  def current_user=(user)
    @current_user = user
  end
  

  

end
