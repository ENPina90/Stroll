class Walk < ApplicationRecord
  belongs_to :user
  belongs_to :stroll_setting
  has_many :stroll_locations
  has_many :locations, through: :stroll_locations

  validates :starting_location, presence: true
  validates :ending_location, presence: true
  validates :significance, presence: true
  validates :category, presence: true
  validates :cost, presence: true

end
