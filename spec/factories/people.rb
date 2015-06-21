FactoryGirl.define do
  factory :person do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    image_url "/images/test.png"
    email { Faker::Internet.email }
    department { ["engineering", "sales", "customer support"].sample }
  end
end
