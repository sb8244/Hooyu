require 'rails_helper'

RSpec.describe QuizController, :type => :controller do
  let!(:person) { FactoryGirl.create(:person, email: "steve.bussey@salesloft.com") }
  let!(:people) { FactoryGirl.create_list(:person, 5) }

  render_views

  describe "GET show" do
    before(:each) { session[:target_id] = people[0].id }

    it "starts out using Question::Name" do
      get :show
      expect(assigns(:next_question_type)).to eq(Question::Name)
    end

    it "doesn't change the target_id" do
      expect {
        get :show
      }.not_to change{ session[:target_id] }.from(people[0].id )
    end

    it "sets the answer correctly" do
      expect {
        get :show
      }.to change{ session[:correct_answer] }.from(nil).to(people[0].display_name)
    end

    context "on question 2" do
      before(:each) { session[:question] = 2 }

      it "uses Question::Department" do
        get :show
        expect(assigns(:next_question_type)).to eq(Question::Department)
      end

      it "sets the answer correctly" do
        expect {
          get :show
        }.to change{ session[:correct_answer] }.from(nil).to(people[0].department)
      end
    end

    context "without a target_id" do
      before(:each) { session[:target_id] = nil }

      it "sets session target_id" do
        expect {
          get :show
        }.to change{ session[:target_id] }.from(nil)
      end
    end

    context "with flash" do
      it "includes flash[:success]" do
        set_flash(:success, "test flash")
        get :show
        expect(response.body).to include("test flash")
      end

      it "includes flash[:error]" do
        set_flash(:error, "test flash")
        get :show
        expect(response.body).to include("test flash")
      end
    end
  end
end
