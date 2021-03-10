class Note < ApplicationRecord
  belongs_to :user
  belongs_to :location

  validates :content, presence: true
  validates :content, length: { minimum: 10, too_short: "Please make sure your notes contain at least 10 characters" }
end
