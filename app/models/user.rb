class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :walks
  has_many :starred_locations,  dependent: :destroy
  has_many :locations, through: :starred_locations
  has_one :stroll_setting, dependent: :destroy
  has_many :notes
  has_many :locations, through: :notes

  after_create :create_settings
  def create_settings
    StrollSetting.create(user: self,
      significance: 3, cost: true, newness: true)
  end
end
