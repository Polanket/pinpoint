class AddedLocation < ApplicationRecord
  belongs_to :location
  belongs_to :map
  has_many :tags
end
