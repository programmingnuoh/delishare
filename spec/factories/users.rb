FactoryBot.define do
  factory :user do
    name { 'sample' }
    email { Faker::Internet.email }
    # password = Faker::Internet.password
    password { 'sample00' }
    password_confirmation { 'sample00' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/testimage.jpg')) }
  end
end