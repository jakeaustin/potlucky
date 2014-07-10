# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
  end
  factory :meal do
    id 1
    title { Faker::Internet.user_name + "'s Get Together" }
    location { Faker::Address.street_address }
    hosted_at { Faker::Business.credit_card_expiry_date }
  end

end
