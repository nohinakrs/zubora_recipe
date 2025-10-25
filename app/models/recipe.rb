class Recipe < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments

  validates :recipe_name, presence: true, uniqueness: true, length: { in: 1..20 }
  validates :recipe, presence: true, length: { in: 100..3000 }

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
end
