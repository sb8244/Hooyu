class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_person
    @current_person ||= Person.find_by(email: "steve.bussey@salesloft.com")
  end
end
