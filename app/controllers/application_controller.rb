class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_person

  def current_person
    return unless current_user

    @current_person ||= current_user.people.first
  end

  private

  def ensure_person
    return if current_person

    redirect_to setup_path
  end

  def ensure_user
    return if current_user

    redirect_to user_omniauth_authorize_path(provider: :google_oauth2)
  end
end
