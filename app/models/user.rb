class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :playlist_foods

  has_secure_password
end