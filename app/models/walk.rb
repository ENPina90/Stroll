class Walk < ApplicationRecord
  belongs_to :user
  belongs_to :stroll_setting
  geocoded_by :starting_location
  after_validation :geocode, if: :will_save_change_to_address?
end
