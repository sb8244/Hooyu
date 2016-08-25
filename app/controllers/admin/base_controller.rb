class Admin::BaseController < ApplicationController
  before_filter :ensure_admin

  def ensure_admin
    redirect_to setup_path unless current_user.admin
  end
end
