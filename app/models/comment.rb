class Comment < ApplicationRecord
  validates :comment, presence: true, length: { in: 100..500 }
end
