class AddedLocation < ApplicationRecord
  serialize :types, Array
  serialize :photo, Array

  belongs_to :map
  has_many :tags
  has_many :reviews

  validates :name, :address, :description, :photo, presence: true
  validates :longitude, :latitude, presence: true, allow_blank: false

  after_create_commit { ::MapMarkerNotificationJob.perform_now(self) }
end
