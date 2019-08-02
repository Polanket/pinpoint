class User < ApplicationRecord
  mount_uploader :avatar, PhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_groups, dependent: :destroy
  has_many :owned_maps, class_name: 'Map'
  has_many :shared_maps, through: :user_groups, source: :map
  has_many :reviews

  validates :email, :password, presence: true
  validates :email, uniqueness: true


  def all_users_but_self
    User.all.select { |user| user != self && user.name != 'guest'}
  end
end
