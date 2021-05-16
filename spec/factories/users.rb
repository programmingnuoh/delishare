FactoryBot.define do
  factory :user do
    name { 'sample' }
    email { Faker::Internet.email }
    # password = Faker::Internet.password
    password { 'sample00' }
    password_confirmation { 'sample00' }
  end
end
