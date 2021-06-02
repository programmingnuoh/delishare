class Deli < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :image
  has_many :deli_tag_relations, dependent: :destroy
  has_many :tags, through: :deli_tag_relations, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :supermarket

end
