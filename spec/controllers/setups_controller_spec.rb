require 'rails_helper'

RSpec.describe SetupsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) { sign_in(user) }

  describe "POST create", vcr: { cassette_name: "setups-controller_post-create-success", match_requests_on: [:body] } do
    let!(:params) {{
        email: "test@test.com",
        first_name: "Steve",
        last_name: "Bussey",
        department: "Engineering",
        profile_image: fixture_file_upload('steve.jpg','image/jpg')
    }}

    it "creates a new person" do
      expect {
        expect {
          post :create, params
        }.to change{ Person.count }.by(1)
      }.to change{ user.reload.people.count }.by(1)
    end

    it "redirects to root" do
      post :create, params
      expect(response).to redirect_to("/")
    end
  end
end
