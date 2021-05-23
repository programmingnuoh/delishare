class Tag < ApplicationRecord
  validates :tagname, uniqueness: true
  has_many :deli_tag_relations
  has_many :delis, through: :deli_tag_relations
end
