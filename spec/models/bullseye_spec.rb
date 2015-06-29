require 'rails_helper'

RSpec.describe Bullseye do
  let!(:person) { FactoryGirl.create(:person, email: "steve.bussey@salesloft.com") }
  let!(:people) { FactoryGirl.create_list(:person, 5) }

  subject { Bullseye.new(person) }

  it "returns a person" do
    expect(subject.call).to be_a(Person)
  end

  context "with a 1st degree and no degree" do
    let!(:people) { FactoryGirl.create_list(:person, 2) }

    before(:each) {
      person.connect_to(people[0])
    }

    it "returns the non connection" do
      5.times { expect(subject.call).to eq(people[1]) }
    end
  end

  context "with a 1st, 2nd, and non-connections" do
    before(:each) {
      person.connect_to(people[0])
      people[0].connect_to(people[1])
    }

    it "returns the secondary connection that isn't connected to person" do
      5.times { expect(subject.call).to eq(people[1]) }
    end
  end

  context "with all 1st but some with weight < 2" do
    let!(:people) { FactoryGirl.create_list(:person, 2) }

    before(:each) {
      person.connect_to(people[0], weight: 2)
      person.connect_to(people[1], weight: 1)
    }

    it "returns the connection with weight 1" do
      5.times { expect(subject.call).to eq(people[1]) }
    end
  end

  context "with all 1st" do
    context "that are maxed out" do
      before(:each) {
        people.each{ |p| person.connect_to(p, weight: PersonConnection::MAX_WEIGHT) }
      }

      it "is nil" do
        expect(subject.call).to eq(nil)
      end

      context "with force" do
        subject { Bullseye.new(person, force: true) }

        it "is a random person" do
          result = 10.times.map{ subject.call }.uniq
          result.each{ |person| expect(person).to be_a(Person) }
          expect(result.count).to be > 1
        end
      end
    end
  end

  context "with people that know me but I don't know anyone" do
    before(:each) {
      people.each{ |p| p.connect_to(person, weight: PersonConnection::MAX_WEIGHT) }
    }

    it "is a person" do
      expect(subject.call).to be_a(Person)
    end
  end
end
