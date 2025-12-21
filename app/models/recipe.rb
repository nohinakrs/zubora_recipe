class Recipe < ApplicationRecord
  attr_accessor :tag_names

  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  validates :recipe_name, presence: true, length: { in: 1..20 }
  validates :recipe, presence: true, length: { in: 100..3000 }

  before_validation :check_post_tags
  after_save :save_tags
  after_find :inport_tags

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Recipe.where(recipe_name: content)
    elsif method == 'forward'
      Recipe.where('recipe_name LIKE ?', content+'%')
    elsif method == 'backward'
      Recipe.where('recipe_name LIKE ?', '%'+content)
    else
      Recipe.where('recipe_name LIKE ?', '%'+content+'%')
    end
  end

  private

  def inport_tags
    self.tag_names = self.tags&.pluck(:name)&.join(",")
  end

  def check_post_tags
    if !tag_names.present?
      errors.add(:base, "tags must present")
    end
  end

  def save_tags
    if tag_names.present?
      tag_list = tag_names&.split(',')&.map{ |o| o.strip }
      # 現在のユーザーの持っているskillを引っ張ってきている
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
      # 今bookが持っているタグと今回保存されたものの差をすでにあるタグとする。古いタグは消す。
      old_tags = current_tags - tag_list
      # 今回保存されたものと現在の差を新しいタグとする。新しいタグは保存
      new_tags = tag_list - current_tags
      
      # Destroy old taggings:
      old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name:old_name)
      end
      
      # Create new taggings:
      new_tags.each do |new_name|
        recipe_tag = Tag.find_or_create_by(name: new_name)
        # 配列に保存
        self.tags << recipe_tag
      end
    end
  end
end

