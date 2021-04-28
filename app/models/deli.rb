class Deli < ApplicationRecord

  with_options presence:true do
    validates :name
    validates :text
    validates :supermarket_id
  end

  belongs_to :user
  belongs_to :category
  has_one_attaced :image
end
