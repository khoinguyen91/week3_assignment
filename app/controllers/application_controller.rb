class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
     helper_method :current_user, :signed_in?, :require_login
  def current_user
  	return @current_user if @current_user
  	if session[:user_id] 
  		@current_user = User.find session[:user_id]
  	end
  end
  def signed_in?
    current_user
  end

  def require_login
    if !signed_in?
      flash[:error] = 'Please login!'
      redirect_to login_path
    end
  end
end
