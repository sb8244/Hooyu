require 'rails_helper'

RSpec.describe QuizController, :type => :controller do
  let!(:person) { FactoryGirl.create(:person, email: "steve.bussey@salesloft.com") }
  let!(:people) { FactoryGirl.create_list(:person, 5) }

  describe "GET show" do
    it "starts out using Question::Name" do
      get :show
      expect(assigns(:next_question_type)).to eq(Question::Name)
    end

    context "on question 2" do
      before(:each) { session[:question] = 2 }

      it "uses Question::Department" do
        get :show
        expect(assigns(:next_question_type)).to eq(Question::Department)
      end
    end
  end
end
