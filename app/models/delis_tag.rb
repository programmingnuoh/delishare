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
    tag = Tag.where(tagname:tagname).first_or_initialize
    tag.save
    DeliTagRelation.create(deli_id: deli.id, tag_id: tag.id)
  end

  # def update(tag_list)
  #   ActiveRecord::Base.transaction do
  #     @deli.update(name: name, text: text, category_id: category_id, supermarket_id: supermarket_id, image:image, user_id:user_id)

  #     @deli.deli_tags.each do |tag|
  #       tag.delete
  #     end
  #     tag_list.each do |tagname|
  #       tag = Tag.where(tagname:tagname).first_or_initialize
  #       tag.save

  #       deli_tag = DeliTagRelation.where(deli_tag: @deli.tag, tag_id: tag.id).first_or_initialize
  #       deli_tag.update(deli_id: @deli.id, tag_id: tag.id)
  #     end
  #   end
  # end

end