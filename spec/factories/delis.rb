FactoryBot.define do
  factory :deli do
    name {'test'}
    text {'test'}
    supermarket_id{rand(1..10)}
    association :user
    association :category
    after(:build) do |deli|
      deli.image.attach(io: File.open("#{Rails.root}/public/testimage.jpg"), filename:'testimage.jpg')
    end
  end
end