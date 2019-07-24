class Review < ApplicationRecord
  belongs_to :added_location
  belongs_to :user

  validates :content, presence: true
  validates :rating, numericality: { only_integer: true, less_than: 6 }, inclusion: { in: [1, 2, 3, 4, 5] }
end
