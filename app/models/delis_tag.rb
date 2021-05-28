class DelisTag
  include ActiveModel::Model
  attr_accessor :name, :text, :category_id, :supermarket_id, :image, :tagname, :user_id, :deli_id, :tag_id

  with_options presence: true do
    validates :name
    validates :text
    validates :supermarket_id
    validates :image
  end

  # def initialize(params: nil, deli: Deli.new)
  #   @deli = deli
  #   params ||= {
  #     name: deli.name,
  #     text: deli.text,
  #     category_id: deli.category_id,
  #     supermarket_id: deli.supermarket_id,
  #     image: deli.image
  #   }
  #   super(params)
  # end

  def save
    # current_tags = self.tags.plunk(:tagname) unless self.tags.nil?
    # old_tags = current_tags - tag_list
    # new_tags = tag_list - current_tags

    # old_tags.each do |old|
    #   self.deli_tags.delete DelisTag.find_by(tagname: old)
    # end

    # new_tags.each do |new|
    #   new_deli_tag = DelisTag.find_or_create_by(tagname: new)
    #   self.deli_tags << new_deli_tags
    # end

    deli = Deli.create(name: name, text: text, category_id: category_id, supermarket_id: supermarket_id, image:image, user_id:user_id)
    # tag_list.each do |name|
      tag = Tag.where(tagname:tagname).first_or_initialize
      tag.save
    # end
    DeliTagRelation.create(deli_id: deli.id, tag_id: tag.id)
  end

  def update(params)
    @form = Deli.where(deli_id: deli.id)
    @form.update(name: name, text: text, category_id: category_id, supermarket_id: supermarket_id, image: image, tagname: tagname, user_id: user_id)
    tag = Tag.where(tagname:tagname).first_or_initialize
    tag.save
    DeliTagRelation.update(deli_id: deli.id, tag_id: tag.id)
  end

  # def to_model
  #   @deli
  # end

  # def persisted?
  #   @deli.persisted?
  # end

end