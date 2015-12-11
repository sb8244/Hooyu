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

    context "with a signed in person", vcr: { cassette_name: "setups-controller_post-create-success-signed-in", match_requests_on: [:body] } do
      let!(:person) { FactoryGirl.create(:person, first_name: "Test", user_id: user.id) }

      it "doesn't create a new person" do
        expect {
          post :create, params
          expect(response).to redirect_to("/")
        }.not_to change{ Person.count }
      end

      it "updates the existing person" do
        expect {
          expect {
            post :create, params
          }.to change{ person.reload.profile_image.url }
        }.to change{ person.reload.first_name }.from("Test").to("Steve")
      end

      it "doesn't require a profile image" do
        params.delete(:profile_image)
        expect {
          post :create, params
          expect(response).to redirect_to("/")
        }.not_to change{ person.reload.profile_image.url }
      end
    end
  end
end
