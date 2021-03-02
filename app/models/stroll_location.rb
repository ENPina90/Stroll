class StrollLocation < ApplicationRecord
  belongs_to :location
  belongs_to :walk
end
