class AddedLocation < ApplicationRecord
  belongs_to :map
  has_many :tags

  validates :name, :address, :description :photo presence: true, uniqueness: true
  validates :longitude, :latitude, presence: true, uniqueness: true, allow_blank: false
end
