class Location < ApplicationRecord
  has_many :stroll_locations
  has_many :walks, through: :stroll_locations
  has_many :starred_locations
  # not sure if line 4 is final
end
