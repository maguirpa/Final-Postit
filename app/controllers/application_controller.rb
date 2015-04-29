class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :owner?, :require_user, :require_owner

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def logged_in?
    !!current_user
  end

  def owner?(post)
    return true if current_user == post.creator
  end

  def require_user
    if !logged_in?
      flash[:error] = 'You have to be logged in to do that.'
      redirect_to root_path
    end
  end

  def sort_by
 
  end

end
