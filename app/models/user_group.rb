class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :map
end
