class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :exception

  helper_method :ajax_url_suffix, :dev?, :prod?, :stage?, :test?

  def dev?; Rails.env == "development"; end
  def prod?; Rails.env == "production"; end
  def stage?; Rails.env == "staging"; end
  def test?; Rails.new == "test"; end

  # Autentication methods
  #----------------------------------------------------------------------
  # Public: Check if the user is right user
  def authenticate_verify_user
    if !current_user.present?
      redirect_to request.referrer
    else
      return true
    end
  end

  def authenticate_admin             # property manager
  	p "-------------------ApplicationController authenticate_admin----------------"
    if !current_user.present?
      redirect_to new_user_session_path
    else
      redirect_to dashboard_path
    end
  end

  alias_method :devise_current_user, :current_user

  # Utility methods
  #----------------------------------------------------------------------
  def ajax_url_suffix
    "?type=ajax"
  end

  def to_b(string)
    string == "true"
  end

end
