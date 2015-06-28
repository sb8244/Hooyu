class SetupsController < ApplicationController
  skip_before_filter :ensure_person
  before_filter :ensure_user

  def show
    @details = {
        first_name: current_user.first_name,
        last_name: current_user.last_name,
        email: current_user.email,
        organization_name: organization.name
    }
  end

  def create
    person = Person.where(email: person_params[:email]).first
    person = Person.create(person_params) unless person

    if person.persisted?
      redirect_to root_path
    else
      redirect_to setup_path
    end
  end

  private

  def organization
    Organization.where(domain: current_user.domain).first
  end

  def person_params
    params.permit(:first_name, :last_name, :email, :profile_image, :department).tap do |p|
      p[:user_id] = current_user.id
    end
  end
end
