class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :walks
  has_many :starred_locations
  has_many :locations, through: :starred_locations
  has_many :stroll_settings
  has_many :notes
  has_many :locations, through: :notes
end
