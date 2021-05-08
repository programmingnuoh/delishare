class Deli < ApplicationRecord

  with_options presence:true do
    validates :name
    validates :text
    validates :supermarket_id
    validates :image
  end

  belongs_to :user
  belongs_to :category
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :supermarket
end
