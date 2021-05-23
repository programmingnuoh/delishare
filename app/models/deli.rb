class Deli < ApplicationRecord
  with_options presence: true do
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

  def self.search(search)
    if search != ""
      Deli.where('name LIKE(?)', "%#{search}%")
      Deli.where('text LIKE(?)', "%#{search}%")
    else
      Deli.all
    end
  end
end
