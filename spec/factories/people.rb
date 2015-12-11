FactoryGirl.define do
  factory :person do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    image_url "/images/test.png"
    profile_image_file_name { 'test.pdf' }
    profile_image_content_type { 'image/png' }
    profile_image_file_size { 1024 }
    email { Faker::Internet.email }
    department { ["engineering", "sales", "customer support"].sample }
  end
end
