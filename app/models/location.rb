class Location < ApplicationRecord
  has_many :stroll_locations, dependent: :destroy
  has_many :walks, through: :stroll_locations
  has_many :starred_locations, dependent: :destroy
  has_many :users, through: :starred_locations
  has_many :notes, dependent: :destroy
  has_many :users, through: :notes
  # not sure if line 4 is final
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
