class StrollSetting < ApplicationRecord
  belongs_to :user
  has_one :walk

  # validates :category, presence: true
  # validates :significance, presence: true
  # validates :cost, presence: true
  # validates :newness, presence: true

  after_create :create_walk
  def create_walk
    Walk.create(user: self.user,
      stroll_setting: self)
  end
end
