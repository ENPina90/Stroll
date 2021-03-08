class StarredLocation < ApplicationRecord
  belongs_to :user
  belongs_to :location
  validates :location, uniqueness: {scope: :user}
end
