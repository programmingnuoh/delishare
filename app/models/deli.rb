class Deli < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :image
  has_many :deli_tag_relations, dependent: :destroy
  has_many :tags, through: :deli_tag_relations, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :supermarket

  def self.search(search)
    if search != ""
      Deli.includes(:tags).where('name LIKE ? OR text LIKE ? OR tagname LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%").references(:tags)
      # Deli.includes(:tags).where('deli.name LIKE ? OR deli.text LIKE ? OR tags.tagname LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%").references(:tags)
    else
      Deli.all
    end
  end
end
