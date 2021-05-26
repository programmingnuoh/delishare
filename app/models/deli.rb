class Deli < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :image
  has_many :deli_tag_relations
  has_many :tags, through: :deli_tag_relations
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
