FactoryBot.define do
  factory :deli do
    name { 'test' }
    text { 'test' }
    supermarket_id { 4 }
    association :category
    association :user
    after(:build) do |deli|
      deli.image.attach(io: File.open("#{Rails.root}/public/testimage.jpg"), filename:'testimage.jpg')
    end
  end
end
