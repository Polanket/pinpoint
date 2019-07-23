class Tag < ApplicationRecord
  belongs_to :added_location
  belongs_to :category
end
