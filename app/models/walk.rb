class Walk < ApplicationRecord
  belongs_to :user
  belongs_to :stroll_setting
  has_one :starting_location
  has_one :ending_location
end
