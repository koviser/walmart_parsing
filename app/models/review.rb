class Review < ApplicationRecord
  validates :product_id, :review_id, presence: true
  validates :review_id, uniqueness: true

  belongs_to :product
end