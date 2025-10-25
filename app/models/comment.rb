class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
    
  validates :comment, presence: true, length: { in: 4..120 }
end