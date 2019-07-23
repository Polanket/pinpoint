class Review < ApplicationRecord
  belongs_to :added_location
  belongs_to :user
end
