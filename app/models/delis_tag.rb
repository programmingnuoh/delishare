class DelisTag
  include ActiveModel::Model
  attr_accessor :name, :text, :category_id, :supermarket_id, :image, :tagname, :user_id, :deli_id, :tag_id

  with_options presence: true do
    validates :name
    validates :text
    validates :supermarket_id
    validates :image
  end

  delegate :persisted?, to: :deli

  def initialize(attributes: nil, deli: Deli.new)
    @deli = deli
    attributes ||= default_attributes
    super(attributes)
  end

  def save(tag_list)
    deli = Deli.create(name: name, text: text, category_id: category_id, supermarket_id: supermarket_id, image:image, user_id:user_id)
    tag_list.each do |new_tag|
      deli_tag = Tag.find_or_create_by(tagname: new_tag)
      deli.tags << deli_tag
    end

    DeliTagRelation.create(deli_id: deli.id, tag_id: tag_id)
  end

  def update(tag_list)
    ActiveRecord::Base.transaction do
    deli = Deli.where(id: deli_id)
    deli.update(name: name, text: text, category_id: category_id, supermarket_id: supermarket_id, image: image, user_id: user_id)
    current_tags = deli.tags.pluck(:tagname) unless deli.tags.nil?
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags

    old_tags.each do |old_name|
      deli.tags.delete Tag.find_by(tagname: old_name)
    end

    new_tags.each do |new_name|
      deli_tag = Tag.find_or_create_by(tagname: new_name)
      deli.tags << deli_tag 
      deli_tag_relation = DeliTagRelation.where(deli_id: deli.id, tag_id: deli_tag.id).forst_or_initialize
      deli_tag_relation.update(deli_id: deli.id, tag_id: deli_tag.id)
    end
    end
  end

  def destroy
    form = Deli.where(id: deli_id)
    form.destroy
  end

  private

  attr_reader :deli, :tag
  def default_attributes
    {
      name: deli.name,
      text: deli.text,
      category_id: deli.category_id,
      supermarket_id: deli.supermarket_id,
      image: deli.image,
      tagname: deli.tags.pluck(:tagname).join(',')
    }
  end
  # def to_model
  #   @form
  # end

  # def persisted?
  #   @deli.persisted?
  # end

end