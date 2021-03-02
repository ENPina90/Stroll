class StrollSetting < ApplicationRecord
  belongs_to :user
  has_many :walks

  validates :type, presence: true
  validates :significance, presence: true
  validates :cost, presence: true
  validates :newnes, presence: true
end
