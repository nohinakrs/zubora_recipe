class GmlRecipe < ApplicationRecord
    belongs_to :recipe

    validates :material, presence: true
end
