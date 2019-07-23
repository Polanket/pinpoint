class AddedLocation < ApplicationRecord
  belongs_to :location
  belongs_to :map
  belongs_to :review
end
