class Category < ApplicationRecord
  has_many :stroll_setting_categories
  has_many :stroll_settings, through: :stroll_setting_categories
end
