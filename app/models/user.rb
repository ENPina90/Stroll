class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :walks
  has_many :starred_locations
  has_many :locations, through: :starred_locations
  has_one :stroll_setting
  has_many :notes
  has_many :locations, through: :notes

  after_create :create_settings
  def create_settings
    StrollSetting.create(user: self,
      category: %(Attractions Architecture Bars Cafes Galleries History Shops Sculpture Street Art),
      significance: 1, cost: 1, newness: true)
  end

end
