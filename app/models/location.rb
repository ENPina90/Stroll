class Location < ApplicationRecord
  has_many :stroll_locations
  has_many :walks, through: :stroll_locations
  has_many :starred_locations
  has many :users, through: :starred_locations
  has_many :notes
  has many :users, through: :notes
  # not sure if line 4 is final

end
