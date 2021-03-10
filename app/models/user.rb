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
      category: ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
      significance: 3, cost: true, newness: true)
  end
end
