class StrollSetting < ApplicationRecord
  belongs_to :user
  has_many :walks

  validates :category, presence: true
  validates :significance, presence: true
  validates :cost, presence: true
  validates :newness, presence: true
end
