class DelisTag
  include ActiveModel::Model
  attr_accessor :name, :text, :category_id, :supermarket_id, :image, :tagname, :user_id, :deli_id, :tag_id

  with_options presence: true do
    validates :name
    validates :text
    validates :supermarket_id
    validates :image
  end

  def save
    deli = Deli.create(name: name, text: text, category_id: category_id, supermarket_id: supermarket_id, image:image, user_id:user_id)
    tag = Tag.create(tagname: tagname)
    deli_tag = DeliTagRelation.create(deli_id: deli.id, tag_id: tag.id)
  end
end