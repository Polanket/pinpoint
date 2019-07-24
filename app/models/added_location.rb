class AddedLocation < ApplicationRecord
  belongs_to :map
  has_many :tags
end
