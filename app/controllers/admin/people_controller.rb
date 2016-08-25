class Admin::PeopleController < Admin::BaseController
  def index
    @people = Person.all
  end
end
