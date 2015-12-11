class SetupsController < ApplicationController
  before_filter :ensure_user, only: [:show]

  def show
    return redirect_to no_org_setup_path unless organization

    @departments = organization.departments
    @details = {
      email: current_user.email,
      organization_name: organization.name,
      first_name: current_person.try!(:first_name) || current_user.first_name,
      last_name: current_person.try!(:last_name) || current_user.last_name,
      image_url: current_person.try!(:profile_image).try!(:url),
      department: current_person.try!(:department)
    }
  end

  def no_org
  end

  def create
    person = if current_person
      current_person.tap { |person| person.update!(person_params) }
    else
      Person.create!(person_params)
    end

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
      p.delete(:profile_image) unless p[:profile_image]
    end
  end

  def prevent_already_setup
    redirect_to root_path if current_person
  end
end
