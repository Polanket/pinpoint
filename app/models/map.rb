class Map < ApplicationRecord
  belongs_to :user
  has_many :locations, through: :added_locations, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
end
