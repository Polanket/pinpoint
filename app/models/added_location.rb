class AddedLocation < ApplicationRecord
  acts_as_taggable_on :tags

  serialize :types, Array
  serialize :photo, Array

  belongs_to :map
  validates :name, :address, :description, :photo, presence: true
  validates :longitude, :latitude, presence: true, allow_blank: false

  after_create_commit { ::MapMarkerNotificationJob.perform_now(self) }
end
