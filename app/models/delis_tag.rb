class DelisTag
  include ActiveModel::Model
  attr_accessor :name, :text, :category_id, :supermarket_id, :image, :tagname

  with_options presence: true do
    validates :name
    validates :text
    validates :supermarket_id
    validates :image
    varidates :tagname
  end

  def save
    deli = Deli.create(name: name, text: text, category_id: category_id, supermarket_id: supermarket_id, image:image)
    tag = Tag.create(tagname: tagname)
    DeliTagRelation.create(deli_id: deli.id, tag_id: tag.id)
  end
end