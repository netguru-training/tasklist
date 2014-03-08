class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :login_required
  helper_method :logged_in?, :current_user
  expose(:auth_path) { "/auth/google_oauth2" }

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  private

  def login_required
    redirect_to login_path unless logged_in?
  end

  def logged_in?
    current_user.present?
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user ||= begin
      if session[:user_id] && (user = User.find_by(id: session[:user_id]))
        user
      end
    end
  end
end
