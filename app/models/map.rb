class Map < ApplicationRecord
  belongs_to :user
  has_many :added_locations, dependent: :destroy
  has_many :user_groups
  has_many :users, through: :user_groups
end
