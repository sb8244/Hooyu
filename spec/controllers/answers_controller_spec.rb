require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let!(:person) { FactoryGirl.create(:person, email: "steve.bussey@salesloft.com", user_id: user.id) }
  let!(:people) { FactoryGirl.create_list(:person, 5) }

  before(:each) { sign_in(user) }

  describe "POST create" do
    context "with a valid session" do
      before(:each) {
        session[:target_id] = people[0].id
        session[:correct_answer] = "test"
      }

      context "with a correct answer" do
        it "increments the question_number by 1" do
          expect {
            post :create, answer: "test"
          }.to change{ session[:question] }.from(nil).to(2)
        end

        it "sets the flash[:success]" do
          expect {
            post :create, answer: "test"
          }.to change{ flash[:success] }.from(nil).to("You got it!")
        end

        context "with the last question" do
          before(:each) { session[:question] = 2 }

          it "wraps question_number to 1" do
            expect {
              post :create, answer: "test"
            }.to change{ session[:question] }.from(2).to(1)
          end

          it "unsets the target_id" do
            expect {
              post :create, answer: "test"
            }.to change{ session[:target_id] }.from(people[0].id).to(nil)
          end
        end

        context "without an existing PersonConnection" do
          it "creates a PersonConnection" do
            expect {
              post :create, answer: "test"
            }.to change{ PersonConnection.all.count }.by(1)

            expect(PersonConnection.first.from_node).to eq(person)
            expect(PersonConnection.first.to_node).to eq(people[0])
            expect(PersonConnection.first.weight).to eq(1)
          end
        end

        context "with an existing PersonConnection" do
          before(:each) { person.connect_to(people[0]) }

          it "doesn't create a new PersonConnection" do
            expect {
              post :create, answer: "test"
            }.not_to change{ PersonConnection.all.count }.from(1)
          end

          context "on question 1" do
            before(:each) { session[:question] = 1 }

            it "doesn't increment the weight because it is beyond the question number" do
              expect {
                post :create, answer: "test"
              }.not_to change{ person.rels.first.weight }.from(1)
            end
          end

          context "on question 2" do
            before(:each) { session[:question] = 2 }

            it "does increment the weight" do
              expect {
                post :create, answer: "test"
              }.to change{ person.rels.first.weight }.from(1).to(2)
            end
          end
        end
      end

      context "with an incorrect answer" do
        it "sets the question_number to 1" do
          expect {
            post :create, answer: "wrong"
          }.to change{ session[:question] }.from(nil).to(1)
        end

        it "sets the question_number to 1" do
          session[:question] = 2
          expect {
            post :create, answer: "wrong"
          }.to change{ session[:question] }.from(2).to(1)
        end

        it "unsets the target_id" do
          expect {
            post :create, answer: "wrong"
          }.to change{ session[:target_id] }.from(people[0].id).to(nil)
        end

        it "sets the flash[:error]" do
          expect {
            post :create, answer: "wrong"
          }.to change{ flash[:error] }.from(nil).to("Not quite...The answer is test.")
        end
      end
    end
  end
end
