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

  def save(tag_list)
    deli = Deli.create(name: name, text: text, category_id: category_id, supermarket_id: supermarket_id, image:image, user_id:user_id)
    # taglist.each do |name|
      # tag = Tag.where(tagname:name).first_or_initialize
      # tag.save
    # end
    tag_list.each do |new_tag|
      deli_tag = Tag.find_or_create_by(tagname: new_tag)
      self.tags << deli_tag
    end

    DeliTagRelation.create(deli_id: deli.id, tag_id: tag.id)
  end

  # def save_tags(tag_list)
    # current_tags = self.tagname.plunk(:tagname) unless self.tagname.nil?
    # old_tags = current_tags - tagname
    # new_tags = tags - current_tags

    # old_tags.each do |old_name|
    #   self.tagname.delete Tag.find_by(tagname: old_name)
    # end

    # new_tags.each do |new_name|
    #   deli_tag = Tag.where(tagname: new_name).first_or_initialize
    #   self.tagname << deli_tag 
    # end
  # end

  def update
    form = Deli.where(id: deli_id)
    form.update(name: name, text: text, category_id: category_id, supermarket_id: supermarket_id, image: image, user_id: user_id)
    tag = Tag.where(tagname:tagname).first_or_initialize
    tag.save
    DeliTagRelation.update(deli_id: deli_id, tag_id: tag.id)
  end

  def destroy
    form = Deli.where(id: deli_id)
    form.destroy
  end

  # def to_model
  #   @form
  # end

  # def persisted?
  #   @deli.persisted?
  # end

end